FactoryGirl.define do
  factory :product_type do
    name { Faker::Commerce.product_name }
    require_workshop false
  end

end
