FactoryGirl.define do
  factory :content_page do
    title { Faker::Name.title }
		content { Faker::Lorem.paragraph }
		slug { Faker::Internet.slug }
		menu false
		link_text { Faker::Name.title }
  end

end
