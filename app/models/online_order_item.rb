class OnlineOrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order, class_name: OnlineOrder, foreign_key: :online_order_id

  attr_accessor :coupon_code

  before_validation :add_name_price

  validates :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }

  private
    def add_name_price
      if self.product
        self.name = self.product.name
        self.price = self.product.online_price
        if self.coupon_code
          if self.coupon_code.products.ids.include?(self.product.id)
            self.discount_amount = (self.price * self.coupon_code.percent/100)
            self.price -= self.discount_amount
          end
        end
      end
    end
end
