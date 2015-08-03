FactoryGirl.define do
	factory :banner do
		name { Faker::Company.catch_phrase }
		image nil
		url { Faker::Internet.url }
	end
end
