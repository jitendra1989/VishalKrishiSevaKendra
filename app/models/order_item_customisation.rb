class OrderItemCustomisation < ActiveRecord::Base
  belongs_to :order_item, counter_cache: :customisations_count
  belongs_to :specification
  [:order_item_id, :specification_id, :value].each{ |n| validates n, presence: true }
end
