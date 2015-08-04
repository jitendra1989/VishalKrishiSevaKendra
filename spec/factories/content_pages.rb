FactoryGirl.define do
  factory :content_page do
    title { Faker::Name.title }
		content { Faker::Lorem.paragraph }
		slug { Faker::Internet.slug }
  end

end
