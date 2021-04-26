class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  has_many :customisations, class_name: "OrderItemCustomisation", dependent: :destroy
  has_many :image_customisations, class_name: "OrderItemImageCustomisation", dependent: :destroy

  before_validation :add_name_price

  validates :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }

  private
    def add_name_price
      if self.product
        self.name = self.product.name
        self.price = self.product.actual_price_without_taxes
      end
    end
end
