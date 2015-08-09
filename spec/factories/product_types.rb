FactoryGirl.define do
  factory :product_type do
    name { Faker::Commerce.product_name }
    require_workshop false
    after(:build) do |product_type|
      product_type.taxes << FactoryGirl.create_list(:tax, 2)
    end
  end

end
