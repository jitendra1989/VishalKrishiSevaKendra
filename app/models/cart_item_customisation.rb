class CartItemCustomisation < ActiveRecord::Base
  belongs_to :cart_item, counter_cache: :customisations_count
  belongs_to :specification
  [:cart_item_id, :specification_id, :value].each{ |n| validates n, presence: true }
end
