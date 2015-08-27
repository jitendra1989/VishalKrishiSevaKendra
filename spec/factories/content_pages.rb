FactoryGirl.define do
  factory :content_page do
    title { Faker::Name.title }
    image {  Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/test.png')))  }
		content { Faker::Lorem.paragraph }
		slug { Faker::Internet.slug }
		menu false
		link_text { Faker::Name.title }
  end

end
