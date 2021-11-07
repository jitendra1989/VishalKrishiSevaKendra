class ProductImage < ApplicationRecord
	mount_uploader :name, ProductImageUploader
  belongs_to :product
end
