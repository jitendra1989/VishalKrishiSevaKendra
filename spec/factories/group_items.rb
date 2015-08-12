FactoryGirl.define do
  factory :group_item do
    product
    association :related_product, factory: :product
    quantity { Faker::Number.number(1).to_i }
  end

end
