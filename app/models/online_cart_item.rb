class OnlineCartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart, class_name: OnlineCart, foreign_key: :online_cart_id
  validates :quantity, presence: true, numericality: true
end
