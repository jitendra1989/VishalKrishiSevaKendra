class OrderItemImageCustomisation < ActiveRecord::Base
  belongs_to :order_item, counter_cache: :image_customisations_count
  belongs_to :characteristic
  belongs_to :characteristic_image
  enum status: %w(pending in_progress completed rework)

  attr_accessor :user_id

  [:order_item_id, :characteristic_id, :characteristic_image_id].each{ |n| validates n, presence: true }

  after_update :add_log

  private
  	def add_log
  		if self.user_id
  			WorkshopImageLog.create(user_id: self.user_id, order_item_image_customisation_id: self.id, info: "Status changed to #{self.status.humanize}")
  		end
  	end
end
