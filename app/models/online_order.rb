class OnlineOrder < ActiveRecord::Base
  belongs_to :customer
  has_many :items, class: OnlineOrderItem, dependent: :destroy
  has_many :taxes, class: OnlineOrderTax, dependent: :destroy

  attr_accessor :online_cart_id

  validates :customer_id, presence: true

  after_initialize :add_customer, if: :new_record?
  after_create :add_cart_items

  private
    def add_customer
      self.customer = OnlineCart.find(self.online_cart_id).customer if self.online_cart_id
    end

    def add_cart_items
      if self.online_cart_id
        online_cart = OnlineCart.includes(:items).find(self.online_cart_id)
        online_cart.items.includes(:product).each do |cart_item|
          self.items.create(product: cart_item.product, quantity: cart_item.quantity)
          cart_item.product.stocks.where(outlet: Outlet.online_outlets.ids).group('outlet_id desc').each do |stock|
            if stock.online_carts.try(:include?, self.online_cart_id.to_s)
              stock.ordered += stock.online_carts[self.online_cart_id.to_s]
              stock.quantity -= stock.online_carts[self.online_cart_id.to_s]
              stock.save!
            else
            end
          end
        end
        online_cart.destroy!
      end
    end
end
