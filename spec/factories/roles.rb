FactoryGirl.define do
	factory :role do
		name { Faker::Lorem.characters(10) }
	end

end
