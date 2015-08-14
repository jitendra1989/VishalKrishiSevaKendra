class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :outlet
  has_many :items, class_name: CartItem, dependent: :destroy
  validates :customer_id, uniqueness: { scope: :outlet_id }
  validates :outlet_id, presence: true

  def add_item(product_id, quantity)
    cart_item = self.items.find_or_initialize_by(product_id: product_id)
    if cart_item.product.is_a? ProductGroup
      added_quantity = []
      cart_item.product.group_items.each do |group_item|
        added_quantity << self.outlet.product_stock(group_item.related_product_id).add_to_cart(quantity.to_i * group_item.quantity)/group_item.quantity
      end
      cart_item.quantity += added_quantity.min
    else
      cart_item.quantity += self.outlet.product_stock(product_id).add_to_cart(quantity.to_i)
    end
    cart_item.save!
  end

  def update_item(product_id, quantity)
    cart_item = self.items.find_or_initialize_by(product_id: product_id)
    new_quantity = quantity.to_i - cart_item.quantity
    new_quantity == 0 ? self.destroy_item(product_id) : self.add_item(product_id, new_quantity)
  end

  def destroy_item(product_id)
    self.items.find_or_initialize_by(product_id: product_id).destroy
  end
end
