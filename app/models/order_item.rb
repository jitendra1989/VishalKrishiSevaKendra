class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  before_validation :add_name_price

  validates :product_id, presence: true
  validates :quantity, numericality: { greater_than: 0, only_integer: true }

  private
    def add_name_price
      self.assign_attributes(self.product.attributes.slice('name', 'price')) if self.product
    end
end
