FactoryGirl.define do
  factory :attribute do
    name { Faker::Lorem.word }
    outlet_only false
    factory :outlet_attribute do
    	outlet_only true
    end
  end

end
