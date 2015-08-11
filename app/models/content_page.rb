class ContentPage < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: :slugged

	[:title, :content].each do |n|
		validates n, presence: true
	end
end
