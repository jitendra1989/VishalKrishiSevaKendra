FactoryGirl.define do
  factory :requirement_item do
		requirement
		product
		quantity { Faker::Number.between(1, 10) }
		price { BigDecimal.new(Faker::Commerce.price.to_s) }
		description { Faker::Lorem.sentence }
	end

end
