FactoryGirl.define do
	trait :basic_user_trait do
		name { Faker::Name.name }
		username { Faker::Internet.user_name }
		email { Faker::Internet.email }
		phone { Faker::Number.number(10).to_i }
	end
	factory :basic_user, class: User do
		basic_user_trait
	end
	factory :user do
		basic_user_trait
		password { Faker::Internet.password }
		address { Faker::Address.street_address }
		pincode { Faker::Number.number(6).to_i }
		city { Faker::Address.city }
		state { Faker::Address.state }
		country { Faker::Address.country }
		outlet
		role { User::ROLES.sample.to_s }
		active false
		factory :active_user do
			active true
		end
	end
end
