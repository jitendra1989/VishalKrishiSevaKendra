FactoryGirl.define do
  factory :product_attribute do
    product
		association :attribute_list, factory: :attribute
		value { Faker::Number.number(2) }
  end

end
