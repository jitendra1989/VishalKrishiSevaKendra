class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true
  validates :quantity, numericality: true
end
