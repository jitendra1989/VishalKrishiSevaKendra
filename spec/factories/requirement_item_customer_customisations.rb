FactoryGirl.define do
  factory :requirement_item_customer_customisation do
    requirement_item
    name { Faker::Lorem.word }
    image { Faker::Lorem.word }
    code { Faker::Lorem.word }
  end

end
