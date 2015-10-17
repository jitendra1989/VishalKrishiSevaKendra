FactoryGirl.define do
	factory :tax, aliases: [:parent_tax] do
		name { Faker::Name.name }
		percentage { rand(1..5) }
		factory :sub_tax do
			fully_taxable true
			association :parent, factory: :parent_tax
			factory :partial_sub_tax do
				fully_taxable false
			end
		end
	end
end
