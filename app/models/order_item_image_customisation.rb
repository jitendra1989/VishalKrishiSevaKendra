class OrderItemImageCustomisation < ActiveRecord::Base
  belongs_to :order_item
  belongs_to :characteristic
  belongs_to :characteristic_image
  [:order_item_id, :characteristic_id, :characteristic_image_id].each{ |n| validates n, presence: true }
end
