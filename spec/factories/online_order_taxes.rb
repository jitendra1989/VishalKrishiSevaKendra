FactoryGirl.define do
  factory :online_order_tax do
    association :order, factory: :online_order
    name { Faker::Lorem.word }
    amount { BigDecimal.new(Faker::Commerce.price.to_s) }
  end

end
