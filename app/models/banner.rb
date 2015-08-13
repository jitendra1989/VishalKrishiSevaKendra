class Banner < ActiveRecord::Base
	mount_uploader :image, BannerUploader

	has_many :banner_categories, dependent: :destroy
	has_many :categories, through: :banner_categories

	validates :name, presence: true
end
