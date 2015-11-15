class OrderItemCustomisation < ActiveRecord::Base
  belongs_to :order_item, counter_cache: :customisations_count
  belongs_to :specification
  enum status: %w(pending in_progress completed rework)

  attr_accessor :user_id

  [:order_item_id, :specification_id, :value].each{ |n| validates n, presence: true }

  after_update :add_log

  private
    def add_log
      if self.user_id
        WorkshopLog.create(user_id: self.user_id, order_item_customisation_id: self.id, info: "Status changed to #{self.status.humanize}")
      end
    end
end