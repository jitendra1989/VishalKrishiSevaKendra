FactoryGirl.define do
	factory :online_order_item do
		association :order, factory: :online_order
		product
		quantity { Faker::Number.between(1, 10) }
	end
end
