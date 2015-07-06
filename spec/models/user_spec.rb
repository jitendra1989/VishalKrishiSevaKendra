require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { FactoryGirl.build(:user) }
	it { expect(user).to be_valid }
	describe "when email format is invalid" do
		it "is invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				user.email = invalid_address
				expect(user).not_to be_valid
			end
		end
	end
	it "has a valid name" do
		user.name = nil
		expect(user).to_not be_valid
	end
	it "has a valid username" do
		user.username = nil
		expect(user).to_not be_valid
	end
	describe "when username is already taken" do
		before do
			user.save
			user_with_same_username = user.dup
			user_with_same_username.username = user_with_same_username.username.upcase
			user_with_same_username.save
		end
		it { should_not be_valid }
	end
	it "has a password" do
		user.password = nil
		expect(user).to_not be_valid
	end
	it "has a valid phone" do
		user.phone = nil
		expect(user).to_not be_valid
	end
	it "has a valid address" do
		user.address = nil
		expect(user).to_not be_valid
	end
	it "has a valid pincode" do
		user.pincode = nil
		expect(user).to_not be_valid
	end
	it "has a valid city" do
		user.city = nil
		expect(user).to_not be_valid
	end
	it "has a valid state" do
		user.state = nil
		expect(user).to_not be_valid
	end
	it "has a valid country" do
		user.country = nil
		expect(user).to_not be_valid
	end
end
