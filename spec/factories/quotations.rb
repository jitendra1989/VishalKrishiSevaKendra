FactoryGirl.define do
  factory :quotation do
    customer
    association :user, factory: :user_with_roles
    discount_amount { BigDecimal.new(Faker::Commerce.price.to_s) }
    after(:build) do |quotation|
      quotation.products << FactoryGirl.build(:quotation_product, quotation: nil)
    end
  end

end
