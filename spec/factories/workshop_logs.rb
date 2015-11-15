FactoryGirl.define do
  factory :workshop_log do
    user
    order_item_customisation
    info { Faker::Company.bs }
  end

end
