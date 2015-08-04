FactoryGirl.define do
  factory :attribute do
    name { Faker::Lorem.word }
    required false
    units { Attribute::UNITS.sample }
    factory :required_attribute do
      required true
    end
  end

end
