FactoryGirl.define do
  factory :product_group, parent: :product, class: ProductGroup do
    after(:build) do |product_group|
      product_group.group_items << FactoryGirl.create_list(:group_item, 2)
    end
  end

end
