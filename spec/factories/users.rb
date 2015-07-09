FactoryGirl.define do
	factory :user, aliases: [:production_manager] do
		name { Faker::Name.name }
		username { Faker::Internet.user_name }
		email { Faker::Internet.email }
		phone { Faker::Number.number(10).to_i }
		password { Faker::Internet.password }
		address { Faker::Address.street_address }
		pincode { Faker::Number.number(6).to_i }
		city { Faker::Address.city }
		state { Faker::Address.state }
		country { Faker::Address.country }
		role User::ROLES.fourth
		outlet
		active false
		factory :active_user do
			active true
		end
		factory :super_admin do
			role User::ROLES.first
		end
		factory :admin do
			role User::ROLES.second
		end
		factory :sales_executive do
			role User::ROLES.third
		end
	end
end
