require 'rc4'
class OnlineOrder < ActiveRecord::Base
  belongs_to :customer
  has_many :items, class: OnlineOrderItem, dependent: :destroy
  has_many :taxes, class: OnlineOrderTax, dependent: :destroy

  attr_accessor :online_cart_id

  store :payment_info, accessors: [ :ebs ], coder: JSON

  validates :customer_id, presence: true

  after_initialize :add_customer, if: :new_record?
  after_create :add_cart_items

  def process_payment_and_place_order(digital_receipt)
    rc4 = RC4.new(ENV['EBS_SECRET_KEY'])
    query_string = Base64.decode64(digital_receipt.gsub(/\s/, '+'))
    self.ebs = rc4.decrypt(query_string)
    self.save if check_transaction_status
  end

  private
    def add_customer
      self.customer = OnlineCart.find(self.online_cart_id).customer if self.online_cart_id
    end

    def add_cart_items
      if self.online_cart_id
        self.subtotal, self.tax_amount = 0, 0
        online_cart = OnlineCart.includes(:items).find(self.online_cart_id)
        online_cart.items.includes(:product).each do |cart_item|
          self.items.create(product: cart_item.product, quantity: cart_item.quantity)
          self.subtotal += cart_item.product.online_price * cart_item.quantity
          Outlet.online_outlets.each do |online_outlet|
            if cart_item.product.is_a? ProductGroup
              cart_item.product.group_items.each do |group_item|
                stock_to_ordered(group_item.related_product, online_outlet)
              end
            else
              stock_to_ordered(cart_item.product, online_outlet)
            end
          end
          OnlineTax.pluck(:name, :percentage).each do |tax|
            amount = self.subtotal * tax[1]/100
            self.taxes.create(name: tax[0], amount: amount)
            self.tax_amount += amount
          end
        end
        save!
        online_cart.destroy!
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
          stock.quantity -= stock.online_carts[self.online_cart_id.to_s]
          stock.save!
        end
      end
end
