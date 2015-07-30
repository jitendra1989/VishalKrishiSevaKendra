FactoryGirl.define do
  factory :coupon_code do
    code { Faker::Code.isbn }
    percent { rand(1..5) }
    active false
    active_from { Faker::Date.between(4.days.ago, Date.today) }
    active_to { Faker::Date.forward(10).to_time }
  end

end
