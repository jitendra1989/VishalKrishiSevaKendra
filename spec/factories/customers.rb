FactoryGirl.define do
  factory :customer do
  	name { Faker::Name.name }
  	email { Faker::Internet.email }
  	mobile { (2..10).to_a.shuffle.join.to_i }
  	phone { (2..10).to_a.shuffle.join.to_i }
  	address { Faker::Address.street_address }
  	pincode { (1..6).to_a.shuffle.join.to_i  }
  	city { Faker::Address.city }
  	state { Faker::Address.state }
  	country { Faker::Address.country }
  	company_name { Faker::Company.name }
  	company_address { Faker::Address.street_address }
  	company_phone { (2..10).to_a.shuffle.join.to_i }
  end
end
