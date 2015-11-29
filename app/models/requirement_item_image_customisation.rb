class RequirementItemImageCustomisation < ActiveRecord::Base
  belongs_to :requirement_item
  belongs_to :characteristic
  belongs_to :characteristic_image
  [:requirement_item_id, :characteristic_id, :characteristic_image_id].each{ |n| validates n, presence: true }
end
