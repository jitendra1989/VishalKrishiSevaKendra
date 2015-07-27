FactoryGirl.define do
  factory :outlet do
  	name { Faker::Company.name }
		city { Faker::Address.city }
		state { Faker::Address.state }
		country { Faker::Address.country }
		online_store false
		factory :online_outlet do
			online_store true
		end
	end
end

