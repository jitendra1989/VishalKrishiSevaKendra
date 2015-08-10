FactoryGirl.define do
	factory :online_tax do
		name { Faker::Name.name }
		percentage { rand(1..5) }
	end
end
