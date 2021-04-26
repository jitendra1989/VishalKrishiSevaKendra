class ContentPage < ApplicationRecord
	extend FriendlyId
	friendly_id :title, use: :slugged
	mount_uploader :image, BannerUploader

	scope :menu_items, -> { where(menu: true) }

	[:title, :content].each do |n|
		validates n, presence: true
	end
	validates :link_text, presence: true, if: :menu?
end
