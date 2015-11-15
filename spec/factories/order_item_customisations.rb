FactoryGirl.define do
  factory :order_item_customisation do
    order_item
    specification
    value { Faker::Number.number(2) }
  end

end
