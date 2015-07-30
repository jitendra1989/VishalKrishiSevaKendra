FactoryGirl.define do
	factory :receipt do
		code { Faker::Code.isbn }
		amount { BigDecimal.new(Faker::Commerce.price.to_s) }
		order
		user
	end

end
