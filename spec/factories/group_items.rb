FactoryGirl.define do
  factory :group_item do
    product
    association :related_product, factory: :product
    quantity { (1..5).to_a.sample }
  end

end
