FactoryGirl.define do
  factory :product_image do
    name { Faker::Lorem.word }
		product
  end

end
