class CartItemImageCustomisation < ApplicationRecord
  belongs_to :cart_item, counter_cache: :image_customisations_count
  belongs_to :characteristic
  belongs_to :characteristic_image
  [:cart_item_id, :characteristic_id, :characteristic_image_id].each{ |n| validates n, presence: true }
end
