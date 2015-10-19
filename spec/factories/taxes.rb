FactoryGirl.define do
	factory :tax do
		name { Faker::Name.name }
		percentage { rand(1..5) }
	end

end
