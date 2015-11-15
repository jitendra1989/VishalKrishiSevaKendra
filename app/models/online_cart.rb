class OnlineCart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :coupon_code
  has_many :items, class_name: OnlineCartItem, dependent: :destroy

  validate :coupon_code_validity

  attr_accessor :coupon_code_string

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

    def coupon_code_validity
      if self.coupon_code_string
        if coupon_code_string != '_destroy'
          coupon = CouponCode.active.find_by(code: coupon_code_string)
          if coupon
            if (self.items.pluck(:product_id) & coupon.products.ids).empty?
              errors.add(:base, 'The coupon code entered is not applicable to any of your selected products')
            else
              self.coupon_code_id = coupon.id
            end
          else
            errors.add(:base, 'The coupon code entered is not a valid anymore!')
          end
        else
          self.coupon_code_id = nil
        end
      end
    end
end
