class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true, numericality: true
  before_destroy :return_stock

  private
    def return_stock
      self.cart.outlet.product_stock(self.product).return_to_stock(self.quantity)
    end
end
