class Banner < ActiveRecord::Base
	mount_uploader :image, BannerUploader
	validates :name, presence: true
end
