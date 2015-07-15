require 'rails_helper'

RSpec.describe Customer, type: :model do
	let(:customer) { FactoryGirl.build(:customer) }
	it { expect(customer).to be_valid }
	it { expect(customer).to respond_to(:quotations) }
	it { expect(customer.full_address).to eq("#{customer.address}, #{customer.city}, #{customer.state} - #{customer.pincode}") }
	describe "when email format is invalid" do
		it "is invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				customer.email = invalid_address
				expect(customer).not_to be_valid
			end
		end
	end
	describe "when email is already taken" do
		before do
			customer.save
			customer_with_same_email = customer.dup
			customer_with_same_email.save
		end
		it { should_not be_valid }
	end
	describe "when a mixed case email address is entered" do
		let(:mixed_case_email) { "MiXeDCase@InteRneT.com" }
		it "should all be lowercase" do
			customer.email = mixed_case_email
			customer.save
			expect(customer.reload.email).to eq mixed_case_email.downcase
		end
	end
	it "has a valid name" do
		customer.name = nil
		expect(customer).to_not be_valid
	end
	describe "mobile" do
		it "has a valid mobile" do
			customer.mobile = nil
			expect(customer).to_not be_valid
		end
		it "has 10 digits only" do
			customer.mobile = "1" * 15
			expect(customer).to_not be_valid
			customer.mobile = "1" * 10
			expect(customer).to be_valid
		end
	end

	it "has a valid phone" do
		customer.phone = nil
		expect(customer).to_not be_valid
	end
	it "has a valid address" do
		customer.address = nil
		expect(customer).to_not be_valid
	end
	describe "pincode" do
		it "has a valid pincode" do
			customer.pincode = nil
			expect(customer).to_not be_valid
		end
		it "has 6 digits only" do
			customer.pincode = "1" * 8
			expect(customer).to_not be_valid
			customer.pincode = "1" * 6
			expect(customer).to be_valid
		end
	end
	it "has a valid city" do
		customer.city = nil
		expect(customer).to_not be_valid
	end
	it "has a valid state" do
		customer.state = nil
		expect(customer).to_not be_valid
	end
	it "has a valid country" do
		customer.country = nil
		expect(customer).to_not be_valid
	end
end
