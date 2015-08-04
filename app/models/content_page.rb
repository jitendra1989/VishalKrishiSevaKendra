class ContentPage < ActiveRecord::Base
	[:title, :content, :slug].each do |n|
		validates n, presence: true
	end
end
