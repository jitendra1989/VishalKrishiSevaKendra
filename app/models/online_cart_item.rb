class OnlineCartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart, class_name: OnlineCart, foreign_key: :online_cart_id

  validates :quantity, presence: true, numericality: true
  before_destroy :return_stock

  private
    def return_stock
      self.product.stocks.where(outlet: Outlet.online_outlets.ids).group('outlet_id desc').each do |stock|
        stock.return_to_stock(stock.online_carts[self.cart.id.to_s]) if stock.online_carts.try(:has_key?, self.cart.id.to_s)
      end
    end
end
