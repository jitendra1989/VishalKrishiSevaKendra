FactoryGirl.define do
  factory :stock do
    quantity { Faker::Number.number(2) }
    opening { Faker::Number.number(2) }
    ordered { Faker::Number.number(2) }
    invoiced { Faker::Number.number(2) }
    new_quantity { Faker::Number.number(2) }
    code { Faker::Code.isbn }
    product
    outlet
  end

end
