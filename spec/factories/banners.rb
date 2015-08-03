FactoryGirl.define do
	factory :banner do
		name { Faker::Company.catch_phrase }
		image {  Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/test.png')))  }
		url { Faker::Internet.url }
	end
end
