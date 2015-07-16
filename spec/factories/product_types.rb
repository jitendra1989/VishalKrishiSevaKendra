FactoryGirl.define do
  factory :product_type do
    name { Faker::Commerce.product_name }
  end

end
