FactoryGirl.define do
  factory :quotation do
    customer
    user
    discount_amount { BigDecimal.new(Faker::Commerce.price.to_s) }
  end

end
