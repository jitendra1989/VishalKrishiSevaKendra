FactoryGirl.define do
  factory :specification do
    name { Faker::Lorem.word }
    required false
    units { Specification::UNITS.sample }
    factory :required_specification do
      required true
    end
  end

end
