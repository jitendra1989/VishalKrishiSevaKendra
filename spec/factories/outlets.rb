FactoryGirl.define do
  factory :outlet do
  	name { Faker::Company.name }
		city { Faker::Address.city }
		state { Faker::Address.state }
		country { Faker::Address.country }
	end
end

