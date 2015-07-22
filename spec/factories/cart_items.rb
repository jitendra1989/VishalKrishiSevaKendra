FactoryGirl.define do
  factory :cart_item do
  	product
  	cart
  	quantity { Faker::Number.number(2) }
  end

end
