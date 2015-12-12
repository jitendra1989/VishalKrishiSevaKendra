class RequirementItemCustomerCustomisation < ActiveRecord::Base
	mount_uploader :image, CharacteristicImageUploader
  belongs_to :requirement_item, counter_cache: :customer_customisations_count
end
