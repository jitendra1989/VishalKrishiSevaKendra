class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :outlet
  has_many :items, class_name: CartItem, dependent: :destroy
  validates :customer_id, uniqueness: { scope: :outlet_id }
  validates :outlet_id, presence: true

  def add(product_id, quantity)
    cart_item = CartItem.find_or_initialize_by(cart: self, product_id: product_id)
    cart_item.quantity += self.outlet.product_stock(product_id).add_to_cart(quantity.to_i)
    cart_item.save!
  end
end
