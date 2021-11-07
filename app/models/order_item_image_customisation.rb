class OrderItemImageCustomisation < ApplicationRecord
  belongs_to :order_item, counter_cache: :image_customisations_count
  belongs_to :characteristic
  belongs_to :characteristic_image
  belongs_to :user
  enum status: %w(pending in_progress completed rework)

  attr_accessor :modifier_id

  [:order_item_id, :characteristic_id, :characteristic_image_id].each{ |n| validates n, presence: true }

  after_update :add_log

  def assign(new_user_id, new_modifier_id)
    self.update_columns(user_id: new_user_id)
    WorkshopImageLog.create(user_id: new_modifier_id, order_item_image_customisation_id: self.id, info: "Assigned to #{User.find_by(id: new_user_id).try(:name)}")
  end


  private
    def add_log
      if self.modifier_id
        WorkshopImageLog.create(user_id: self.modifier_id, order_item_image_customisation_id: self.id, info: "Status changed to #{self.status.humanize}")
      end
    end
end
