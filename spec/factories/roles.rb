FactoryGirl.define do
	factory :role do
		name { Faker::Lorem.characters(10) }
		discount_percent { BigDecimal.new(Faker::Number.decimal(1,2)) }
	end

end
