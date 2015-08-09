FactoryGirl.define do
  factory :order_tax do
    order
    name { Faker::Lorem.word }
    amount { BigDecimal.new(Faker::Commerce.price.to_s) }
  end

end
