class Order < ActiveRecord::Base
  belongs_to :customer, counter_cache: true
  belongs_to :user
  belongs_to :outlet
  belongs_to :invoice
  has_many :receipts, dependent: :destroy
  has_many :items, class: OrderItem, dependent: :destroy
  has_many :taxes, class: OrderTax, dependent: :destroy

  attr_accessor :cart_id

  [:customer_id, :user_id, :outlet_id].each { |n| validates n, presence: true }
  [:subtotal, :tax_amount, :discount_amount].each { |n| validates n, numericality: true }
  validate :allowed_discount

  store :details, accessors: [ :flagged_by, :comment ], coder: JSON

  after_initialize :add_customer, if: :new_record?
  after_create :add_cart_items

  def unpaid_amount
    self.subtotal + self.tax_amount - (self.receipts.pluck(:amount).sum + self.discount_amount)
  end

  def total
    self.subtotal + self.tax_amount - self.discount_amount
  end

  private
    def allowed_discount
      if self.cart_id && self.user && self.discount_amount
        total = Cart.find(self.cart_id).items.map{ |x| x.product.price_with_taxes * x.quantity }.sum
        allowed_amount = (total * self.user.allowed_discount/100) + 100
        errors.add(:discount_amount, "cannot exceed #{self.user.allowed_discount}%") if self.discount_amount > allowed_amount
      end
    end

    def add_customer
      self.customer = Cart.find(self.cart_id).customer if self.cart_id
      self.subtotal, self.tax_amount = 0, 0
    end
    def add_cart_items
      if self.cart_id
        self.subtotal, self.tax_amount = 0, 0
        taxes_on_products = {}
        cart = Cart.includes(:items).find(self.cart_id)
        cart.items.includes(:product).each do |cart_item|
          order_item = self.items.create(product: cart_item.product, quantity: cart_item.quantity)
          cart_item.customisations.each { |c| order_item.customisations.create(specification_id: c.specification_id, value: c.value) }
          cart_item.image_customisations.each { |c| order_item.image_customisations.create(characteristic_id: c.characteristic_id, characteristic_image_id: c.characteristic_image_id) }
          self.subtotal += cart_item.product.actual_price_without_taxes * cart_item.quantity
          self.tax_amount += cart_item.product.tax_amount(cart_item.product.actual_price_without_taxes) * cart_item.quantity
          cart_item.product.tax_amount_breakup(cart_item.product.actual_price_without_taxes * cart_item.quantity).each do |tax_name, tax_info|
            taxes_on_products[tax_name] ||= { amount: 0, percentage: 0 }
            taxes_on_products[tax_name][:amount] += tax_info[:amount]
            taxes_on_products[tax_name][:percentage] = tax_info[:percentage]
          end
          unless cart_item.product.is_a? ProductGroup
            stock = self.outlet.product_stock(cart_item.product)
            stock.ordered += cart_item.quantity
            stock.quantity -= cart_item.quantity
            stock.save!
          end
        end
        taxes_on_products.each do |tax|
          self.taxes.create(name: tax[0], amount: tax[1][:amount], percentage: tax[1][:percentage])
        end
        save!
        cart.destroy!
      end
    end

end
