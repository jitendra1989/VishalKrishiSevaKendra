FactoryGirl.define do
	factory :order do
		customer
		user
		outlet
		discount_amount { BigDecimal.new(Faker::Commerce.price.to_s) }
  end

end
