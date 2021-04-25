require 'rc4'
class OnlineOrder < ActiveRecord::Base
  include HumanNumbers
  belongs_to :customer
  belongs_to :coupon_code
  has_many :items, class_name: OnlineOrderItem, dependent: :destroy
  has_many :taxes, class_name: OnlineOrderTax, dependent: :destroy

  attr_accessor :online_cart_id

  store :payment_info, accessors: [ :ebs ], coder: JSON

  validates :customer_id, presence: true

  after_create :add_cart_items

  def process_payment_and_place_order(digital_receipt)
    rc4 = RC4.new(ENV['EBS_SECRET_KEY'])
    query_string = Base64.decode64(digital_receipt.gsub(/\s/, '+'))
    self.ebs = rc4.decrypt(query_string)
    self.save if check_transaction_status
  end

  def total
    self.subtotal + self.tax_amount
  end

  private

    def add_cart_items
      if self.online_cart_id
        self.subtotal, self.tax_amount = 0, 0
        online_cart = OnlineCart.includes(:items).find(self.online_cart_id)
        self.coupon_code_id = online_cart.coupon_code_id
        online_cart.items.includes(:product).each do |cart_item|
          item = self.items.create(product: cart_item.product, quantity: cart_item.quantity, coupon_code: self.coupon_code)
          self.subtotal += (item.price * item.quantity)
          Outlet.online_outlets.each do |online_outlet|
            if cart_item.product.is_a? ProductGroup
              cart_item.product.group_items.each do |group_item|
                stock_to_ordered(group_item.related_product, online_outlet)
              end
            else
              stock_to_ordered(cart_item.product, online_outlet)
            end
          end
        end
        online_tax_calculator(OnlineTax.all.arrange, self.subtotal, 0)
        save!
        online_cart.items.each(&:delete)
        online_cart.destroy!
        Front::OrderMailer.success(self).deliver_now
      end
    end

    def check_transaction_status
      items = {}
      self.ebs.split('&').each do |info|
        item = info.split('=')
        items[item[0]] = item[1]
      end
      items['ResponseCode'] == '0'
    end
    private
      def stock_to_ordered(product, online_outlet)
        stock = online_outlet.product_stock(product)
        if stock && stock.online_carts.try(:include?, self.online_cart_id.to_s)
          stock.ordered += stock.online_carts[self.online_cart_id.to_s]
          stock.in_carts -= stock.online_carts[self.online_cart_id.to_s]
          stock.online_carts.delete(self.online_cart_id.to_s)
          stock.save!
        end
      end

      def online_tax_calculator(hash, parent_amount = 0, taxable_amount = 0)
        hash.each do |tax, children|
          if tax.fully_taxable? || tax.root?
            level_amount = (parent_amount + taxable_amount) * tax.percentage/100
          else
            level_amount = taxable_amount * tax.percentage/100
          end
          self.taxes.create(name: tax.name, percentage: tax.percentage, amount: level_amount)
          self.tax_amount += level_amount
          online_tax_calculator(children, parent_amount, level_amount) unless children.empty?
        end
      end
end
