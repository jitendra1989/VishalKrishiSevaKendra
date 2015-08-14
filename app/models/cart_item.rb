class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true, numericality: true
  before_destroy :return_stock

  private
    def return_stock
      if self.product.is_a? ProductGroup
        self.product.group_items.each do |group_item|
          self.cart.outlet.product_stock(group_item.related_product).return_to_stock(group_item.quantity/self.quantity)
        end
      else
        self.cart.outlet.product_stock(self.product).return_to_stock(self.quantity)
      end
    end
end
