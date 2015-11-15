class CartItemImageCustomisation < ActiveRecord::Base
  belongs_to :cart_item
  belongs_to :characteristic
  belongs_to :characteristic_image
  [:cart_item_id, :characteristic_id, :characteristic_image_id].each{ |n| validates n, presence: true }
end
