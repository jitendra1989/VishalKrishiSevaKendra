class RequirementItemCustomerCustomisation < ApplicationRecord
	mount_uploader :image, CharacteristicImageUploader
	belongs_to :requirement_item, counter_cache: :customer_customisations_count

	attr_accessor :data_uri_image
	before_save :set_image

	def data_uri_image=(value)
		attribute_will_change!('image') if @data_uri_image != value
		@data_uri_image = value
	end

	private
		def set_image
			if self.data_uri_image.present?
				self.image_data_uri = self.data_uri_image
				self.data_uri_image = nil
				save
			end
		end
end
