FactoryGirl.define do
	factory :user, aliases: [:production_manager] do
		name { Faker::Name.name }
		username { Faker::Internet.user_name }
		email { Faker::Internet.email }
		phone { Faker::Number.number(10).to_i }
		password { Faker::Internet.password }
		address { Faker::Address.street_address }
		pincode { (1..6).to_a.shuffle.join.to_i }
		city { Faker::Address.city }
		state { Faker::Address.state }
		country { Faker::Address.country }
		outlet
		active false
		factory :active_user do
			active true
		end
		factory :super_admin do
		end
		factory :admin do
		end
		factory :sales_executive do
		end
	end
end
