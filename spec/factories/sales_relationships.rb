FactoryGirl.define do
  factory :sales_relationship do
    product
    association :related_product, factory: :product
  end

end
