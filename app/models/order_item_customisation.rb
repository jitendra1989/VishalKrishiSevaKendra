class OrderItemCustomisation < ActiveRecord::Base
  belongs_to :order_item
  belongs_to :specification
  [:order_item_id, :specification_id, :value].each{ |n| validates n, presence: true }
end
