class ContentPage < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	[:title, :content].each do |n|
		validates n, presence: true
	end
	validates :link_text, presence: true, if: :menu?
end
