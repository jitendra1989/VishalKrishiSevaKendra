class OnlineCartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart, class_name: OnlineCart, foreign_key: :online_cart_id

  validates :quantity, presence: true, numericality: true
  before_destroy :return_stock

  private
    def return_stock
      Outlet.online_outlets.each do |online_outlet|
        stock = online_outlet.product_stock(self.product)
        stock.return_to_stock(stock.online_carts[self.cart.id.to_s]) if stock && stock.try(:online_carts).try(:has_key?, self.cart.id.to_s)
      end
    end
end
