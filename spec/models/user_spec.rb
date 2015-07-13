require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { FactoryGirl.build(:user) }
	let(:super_admin) { FactoryGirl.create(:super_admin) }
	let(:admin) { FactoryGirl.create(:admin) }
	let(:sales_executive) { FactoryGirl.create(:sales_executive) }
	let(:production_manager) { FactoryGirl.create(:production_manager) }
	it { expect(user).to be_valid }
	it { expect(user).to respond_to(:outlet) }
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
	it "has a role" do
		user.role = nil
		expect(user).to_not be_valid
	end
	it "has a valid role" do
		user.role = 'randomtext'
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
	describe "pincode" do
		it "has a valid pincode" do
			user.pincode = nil
			expect(user).to_not be_valid
		end
		it "has 6 digits only" do
			user.pincode = "1" * 8
			expect(user).to_not be_valid
			user.pincode = "1" * 6
			expect(user).to be_valid
		end
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
	describe 'role method checks' do
		describe "super admin" do
			it { expect(super_admin.super_admin?).to eq(true) }
			it { expect(admin.super_admin?).to eq(false) }
			it { expect(sales_executive.super_admin?).to eq(false) }
			it { expect(production_manager.super_admin?).to eq(false) }
		end
		describe "admin" do
			it { expect(sales_executive.admin?).to eq(false) }
			it { expect(admin.admin?).to eq(true) }
			it { expect(production_manager.admin?).to eq(false) }
		end
		describe "sales executive" do
			it { expect(sales_executive.sales_executive?).to eq(true) }
			it { expect(admin.sales_executive?).to eq(false) }
			it { expect(production_manager.sales_executive?).to eq(false) }
			it { expect(super_admin.sales_executive?).to eq(false) }
		end
		describe "production manager" do
			it { expect(production_manager.production_manager?).to eq(true) }
			it { expect(admin.production_manager?).to eq(false) }
			it { expect(sales_executive.production_manager?).to eq(false) }
			it { expect(super_admin.production_manager?).to eq(false) }
		end
	end
end
