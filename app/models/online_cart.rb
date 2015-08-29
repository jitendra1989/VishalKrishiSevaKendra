class OnlineCart < ActiveRecord::Base
  belongs_to :customer
  has_many :items, class_name: OnlineCartItem, dependent: :destroy

  def add_item(product_id, quantity)
    cart_item = self.items.find_or_initialize_by(product_id: product_id)
    cart_item.quantity += quantity.to_i
    cart_item.save!
  end

  def update_item(product_id, quantity)
    quantity.to_i == 0 ? self.destroy_item(product_id) : change_quantity(product_id, quantity.to_i)
  end

  def destroy_item(product_id)
    self.items.find_or_initialize_by(product_id: product_id).destroy
  end

  def check_and_block_stock
    unless self.blocked_at
      self.items.each do |item|
        new_quantity = item.product.add_to_online_cart(item.quantity, self.id)
        item.update(quantity: new_quantity)
      end
      self.update(blocked_at: Time.zone.now)
      OnlineCartWorker.perform_in(block_period, self.id)
    end
  end

  def place_order_by
    self.blocked_at ? self.blocked_at + block_period : Time.zone.now
  end

  def return_blocked_stock
    if self.blocked_at
      self.update(blocked_at: nil)
      self.items.each { |item| item.return_stock }
    end
  end

  private
    def change_quantity(product_id, quantity)
      cart_item = self.items.find_or_initialize_by(product_id: product_id)
      cart_item.update(quantity: quantity)
    end

    def block_period
      15.minutes
    end
end
