FactoryGirl.define do
	factory :invoice do
		customer
		after(:build) do |invoice|
			invoice.orders << FactoryGirl.build(:order, customer: invoice.customer)
		end
	end
end
