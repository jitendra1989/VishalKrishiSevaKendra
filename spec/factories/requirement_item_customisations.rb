FactoryGirl.define do
  factory :requirement_item_customisation do
		requirement_item
		specification
		value { Faker::Number.number(2) }
  end

end
