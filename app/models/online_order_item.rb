class OnlineOrderItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order, class_name: OnlineOrder, foreign_key: :online_order_id

  before_validation :add_name_price

  validates :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }

  private
    def add_name_price
      if self.product
        self.name = self.product.name
        self.price = self.product.online_price
      end
    end
end
