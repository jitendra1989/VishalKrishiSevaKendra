FactoryGirl.define do
  factory :stock do
    new_quantity { (10..20).to_a.sample }
    code { Faker::Code.isbn }
    supplier_name { Faker::Name.name }
    invoice_date { Faker::Date.forward(1) }
    invoice_number { Faker::Number.between(1, 10) }
    product
    outlet
  end

end
