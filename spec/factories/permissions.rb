FactoryGirl.define do
	factory :permission do
		name { Faker::Lorem.word }
		action { Faker::Lorem.word  }
		description { Faker::Company.bs  }
	end

end
