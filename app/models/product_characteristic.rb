class ProductCharacteristic < ActiveRecord::Base
  belongs_to :product
  belongs_to :characteristic
  belongs_to :characteristic_image
  [:product_id, :characteristic_id, :characteristic_image_id].each{ |n| validates n, presence: true }
  validates :characteristic_id, uniqueness: { scope: :product_id }
end
