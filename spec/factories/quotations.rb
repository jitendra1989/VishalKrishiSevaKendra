FactoryGirl.define do
  factory :quotation do
    customer
    user
    discount_amount { BigDecimal.new(Faker::Commerce.price.to_s) }
    after(:build) do |quotation|
      quotation.products << FactoryGirl.build(:quotation_product, quotation: nil)
    end
  end

end
