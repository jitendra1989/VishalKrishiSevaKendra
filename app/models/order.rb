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

  after_initialize :add_customer, if: :new_record?
  after_create :add_cart_items

  def unpaid_amount
    self.subtotal + self.tax_amount - (self.receipts.pluck(:amount).sum + self.discount_amount)
  end

  def total
    self.subtotal + self.tax_amount - self.discount_amount
  end

  private
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
          self.items.create(product: cart_item.product, quantity: cart_item.quantity)
          self.subtotal += cart_item.product.price * cart_item.quantity
          self.tax_amount += cart_item.product.tax_amount * cart_item.quantity
          cart_item.product.taxes.each do |tax|
            taxes_on_products[tax.name] ||= 0
            taxes_on_products[tax.name] += (cart_item.product.price * cart_item.quantity) * tax.percentage/100
          end
          unless cart_item.product.is_a? ProductGroup
            stock = self.outlet.product_stock(cart_item.product)
            stock.ordered += cart_item.quantity
            stock.quantity -= cart_item.quantity
            stock.save!
          end
        end
        taxes_on_products.each do |tax|
          self.taxes.create(name: tax[0], amount: tax[1])
        end
        save!
        cart.destroy!
      end
    end

end
