class OnlineCartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart, class_name: OnlineCart, foreign_key: :online_cart_id

  validates :quantity, presence: true, numericality: true
  before_destroy :return_stock

  private
    def return_stock
      Outlet.online_outlets.each do |online_outlet|
        if self.product.is_a? ProductGroup
          self.product.group_items.each do |group_item|
            stock = online_outlet.product_stock(group_item.related_product)
            stock.return_to_stock(stock.online_carts[self.cart.id.to_s]) if stock && stock.try(:online_carts).try(:has_key?, self.cart.id.to_s)
          end
        else
          stock = online_outlet.product_stock(self.product)
          stock.return_to_stock(stock.online_carts[self.cart.id.to_s]) if stock && stock.try(:online_carts).try(:has_key?, self.cart.id.to_s)
        end



      end
    end
end
