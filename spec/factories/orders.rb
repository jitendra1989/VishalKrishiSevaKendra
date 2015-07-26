FactoryGirl.define do
	factory :order do
		customer
		user
		outlet
		discount_amount { BigDecimal.new(Faker::Commerce.price.to_s) }
		after(:build) do |order|
		  order.items << FactoryGirl.build(:order_item, order: nil)
		end
  end

end
