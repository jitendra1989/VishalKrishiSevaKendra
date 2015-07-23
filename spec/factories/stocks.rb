FactoryGirl.define do
  factory :stock do
    new_quantity { Faker::Number.number(2).to_i }
    code { Faker::Code.isbn }
    product
    outlet
  end

end
