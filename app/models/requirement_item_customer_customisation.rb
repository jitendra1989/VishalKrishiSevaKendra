class RequirementItemCustomerCustomisation < ActiveRecord::Base
	mount_uploader :image, CharacteristicImageUploader
  belongs_to :requirement_item
end
