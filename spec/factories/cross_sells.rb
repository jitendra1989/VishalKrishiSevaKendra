FactoryGirl.define do
  factory :cross_sell, parent: :sales_relationship do
    product
    association :related_product, factory: :product
  end

end
