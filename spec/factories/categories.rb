FactoryGirl.define do
	factory :category, aliases: [:parent_category] do
		name {Faker::Commerce.department}
		factory :sub_category do
			association :parent, factory: :parent_category
		end
	end
end
