FactoryGirl.define do
	factory :user do
		name { Faker::Name.name }
		username { Faker::Internet.user_name }
		password { Faker::Internet.password }
		email { Faker::Internet.email }
		phone { Faker::Number.number(10) }
		address { Faker::Address.street_address }
		pincode { Faker::Number.number(6) }
		city { Faker::Address.city }
		state { Faker::Address.state }
		country { Faker::Address.country }
		active false
		factory :active_user do
			active true
		end
	end
end
