FactoryGirl.define do
	factory :quotation_product do
		quotation
		product
		name { product.name }
		quantity { Faker::Number.between(1, 10) }
		price { product.price }
	end

end
