class OnlineCart < ActiveRecord::Base
  belongs_to :customer
  has_many :items, class_name: OnlineCartItem, dependent: :destroy

  def add_item(product_id, quantity)
    cart_item = self.items.find_or_initialize_by(product_id: product_id)
    cart_item.quantity += cart_item.product.add_to_online_cart(quantity.to_i, self.id)
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
