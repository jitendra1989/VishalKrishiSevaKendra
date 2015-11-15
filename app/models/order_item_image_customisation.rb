class OrderItemImageCustomisation < ActiveRecord::Base
  belongs_to :order_item, counter_cache: :image_customisations_count
  belongs_to :characteristic
  belongs_to :characteristic_image
  [:order_item_id, :characteristic_id, :characteristic_image_id].each{ |n| validates n, presence: true }
end
