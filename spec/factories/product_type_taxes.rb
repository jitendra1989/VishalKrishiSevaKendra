FactoryGirl.define do
  factory :product_type_tax do
    product_type
    tax
    fully_taxable { [true, false].sample }
  end

end
