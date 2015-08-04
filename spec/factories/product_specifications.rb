FactoryGirl.define do
  factory :product_specification do
    product
    specification
		value { Faker::Number.number(2) }
  end

end
