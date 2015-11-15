FactoryGirl.define do
  factory :workshop_image_log do
    user
    order_item_image_customisation
    info { Faker::Company.bs }
  end

end
