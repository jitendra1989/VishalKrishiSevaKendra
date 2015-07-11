class ProductImage < ActiveRecord::Base
	mount_uploader :name, ProductImageUploader
  belongs_to :product
end
