FactoryGirl.define do
	factory :product do
		name { Faker::Commerce.product_name }
		code { Faker::Code.isbn }
		description { Faker::Lorem.sentence }
		price { BigDecimal.new(Faker::Commerce.price.to_s) }
		sale_price { price * rand() }
		product_type
		saleable_online false
		active true
		factory :online_product do
			saleable_online true
		end
		factory :inactive_product do
			active false
		end
	end
end
