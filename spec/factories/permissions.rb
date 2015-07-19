FactoryGirl.define do
	factory :permission do
		name { Faker::Lorem.word }
		subject_class { Faker::Lorem.word }
		subject_id nil
		action { Faker::Lorem.word  }
		description { Faker::Company.bs  }
	end

end
