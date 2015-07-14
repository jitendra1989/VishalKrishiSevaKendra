FactoryGirl.define do
	factory :quotation_product do
		quotation
		product
		quantity { Faker::Number.between(1, 10) }
	end

end
