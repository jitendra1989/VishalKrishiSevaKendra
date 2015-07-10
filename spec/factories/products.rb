FactoryGirl.define do
	factory :product do
		name { Faker::Commerce.product_name }
		code { Faker::Code.isbn }
		description { Faker::Lorem.sentence }
		price { Faker::Commerce.price }
		active true
		factory :inactive_product do
			active false
		end
	end
end
