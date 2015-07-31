FactoryGirl.define do
	factory :invoice do
		customer
		amount { BigDecimal.new(Faker::Commerce.price.to_s) }
  end
end
