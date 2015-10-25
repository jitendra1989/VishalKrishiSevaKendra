FactoryGirl.define do
  factory :product_type_tax, aliases: [:root_product_type_tax] do
    product_type
    tax
    factory :child_product_type_tax do
      fully_taxable { [true, false].sample }
      association :parent, factory: :root_product_type_tax
    end
  end

end
