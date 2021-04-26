class Banner < ApplicationRecord
	mount_uploader :image, BannerUploader

	enum location: [:top, :column_1, :column_2, :column_3, :column_4]

	has_many :banner_categories, dependent: :destroy
	has_many :categories, through: :banner_categories

	validates :name, presence: true
end
