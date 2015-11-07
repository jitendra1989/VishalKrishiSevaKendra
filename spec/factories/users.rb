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
			after(:create) do |user|
				user.permissions << FactoryGirl.create(:permission, name: :all, action: :manage)
			end
		end
		factory :user_with_roles do
			after(:create) do |user|
				user.roles << FactoryGirl.create_list(:role, 2)
			end
		end
		factory :admin do
		end
		factory :user_developer do
			developer true
		end
		factory :user_store_boss do
			store_boss true
		end
		factory :user_main_boss do
			main_boss true
		end
	end
end
