FactoryGirl.define do
  factory :characteristic_image do
    name { Faker::Lorem.word }
    characteristic
  end

end
