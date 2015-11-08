FactoryGirl.define do
  factory :cart_item_customisation do
  	cart_item
  	specification
  	value { Faker::Number.number(2) }
  end

end
