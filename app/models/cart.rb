class Cart < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :outlet
  has_many :items, class_name: CartItem, dependent: :destroy
  validates :customer_id, uniqueness: { scope: :outlet_id }
end
