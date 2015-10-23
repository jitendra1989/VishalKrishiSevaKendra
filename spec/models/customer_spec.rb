require 'rails_helper'

RSpec.describe Customer, type: :model do
	let(:unsaved_customer) { FactoryGirl.build(:customer) }
	let(:customer) { FactoryGirl.create(:customer) }
	it { expect(customer).to be_valid }
	it { expect(customer).to respond_to(:quotations) }
	it { expect(customer).to respond_to(:carts) }
	it { expect(customer).to respond_to(:orders) }
	it { expect(customer).to respond_to(:invoices) }
	it { expect(customer).to respond_to(:online_cart) }
	it { expect(customer).to respond_to(:online_orders) }
	it { expect(customer).to respond_to(:current_step) }
	it { expect(customer).to respond_to(:admin_customer) }
	it { expect(customer.full_address).to eq("#{customer.address}, #{customer.city}, #{customer.state} - #{customer.pincode}") }
	describe "when creating customer in admin" do
		before do
			unsaved_customer.admin_customer = true
			unsaved_customer.password = nil
			unsaved_customer.password_confirmation = nil
			unsaved_customer.email = nil
		end
		it 'does not require password or email' do
			expect(unsaved_customer).to be_valid
		end
		it 'requires name and phone' do
			unsaved_customer.name = nil
			expect(unsaved_customer).not_to be_valid
		end
	end
	describe "when only resetting password" do
		before do
			customer.name = nil
			customer.current_step = 'password_reset'
			customer.password = '123'
			customer.save!
		end
		it "does not validate" do
			expect(customer.authenticate('123')).to eq customer
		end
	end
	describe "when email format is invalid" do
		it "is invalid" do
			addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
			addresses.each do |invalid_address|
				unsaved_customer.email = invalid_address
				expect(unsaved_customer).not_to be_valid
			end
		end
	end
	describe "when email is already taken" do
		before do
			unsaved_customer.save
			customer_with_same_email = customer.dup
			customer_with_same_email.save
		end
		it { should_not be_valid }
	end
	describe "when a mixed case email address is entered" do
		let(:mixed_case_email) { "MiXeDCase@InteRneT.com" }
		it "should all be lowercase" do
			unsaved_customer.email = mixed_case_email
			unsaved_customer.save
			expect(unsaved_customer.reload.email).to eq mixed_case_email.downcase
		end
	end
	it "has a valid name" do
		customer.name = nil
		expect(customer).to_not be_valid
	end
	it "has a password" do
		unsaved_customer.password = nil
		expect(unsaved_customer).to_not be_valid
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
			customer.pincode = '403' + ('1' * 3)
			expect(customer).to be_valid
		end
		it "begins with 403" do
			customer.pincode = 233003
			expect(customer).to_not be_valid
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
	describe 'activate cart' do
		let(:user) { FactoryGirl.create(:user) }
		let!(:customer_cart) { FactoryGirl.create(:cart, user: user, outlet: user.outlet, customer: customer) }
		let!(:blank_cart) { FactoryGirl.create(:cart, user: user, outlet: user.outlet, customer: nil) }
		before do
			customer.save!
		end
		it 'returns the customer cart for the current outlet' do
			expect(customer.activate_cart(user)).to eq(customer_cart)
		end
		describe 'no active cart for the current outlet' do
			before do
				customer_cart.destroy!
			end
			it 'assigns the first blank cart' do
				customer.activate_cart(user)
				expect(blank_cart.reload.customer).to eq(customer)
			end
			it 'returns the first blank cart' do
				expect(customer.activate_cart(user)).to eq(blank_cart)
			end
		end
	end
	describe 'Merge customer carts' do
		let(:customer_cart) { FactoryGirl.create(:online_cart, customer: customer) }
		let(:session_cart) { FactoryGirl.create(:online_cart, customer: nil) }
		before do
			FactoryGirl.create_list(:online_cart_item, 3, cart: session_cart)
		end
		describe 'without existing cart' do
			it 'assigns customer to the active cart' do
				customer.set_online_cart(session_cart.id)
				expect(session_cart.reload.customer).to eq(customer)
			end
			it 'returns the customer cart id' do
				expect(customer.set_online_cart(session_cart.id)).to eq(session_cart.id)
			end
			it 'returns nil if no cart has been created yet' do
				expect(customer.set_online_cart(nil)).to eq(nil)
			end
		end
		describe 'with existing cart' do
			before do
				FactoryGirl.create_list(:online_cart_item, 3, cart: customer_cart)
			end
			it 'merges customer cart with session cart if specified' do
				customer_cart_items_count = customer_cart.items.count
				session_cart_items_count = session_cart.items.count
				customer.set_online_cart(session_cart.id)
				expect(customer_cart.reload.items.count).to eq(customer_cart_items_count + session_cart_items_count)
			end
			it "destroys the session based cart" do
				expect{
					customer.set_online_cart(session_cart.id)
					}.to change(OnlineCart, :count).by(-1)
			end
			it 'returns the customer cart id' do
				expect(customer.set_online_cart(session_cart.id)).to eq(customer_cart.id)
			end
		end
	end

	describe "on creation of account" do
		it "generates an activation_digest" do
			customer.save!
			expect(customer.activation_digest).not_to be_nil
		end
		it "sends an email" do
			expect{ customer.save! }.to change { ActionMailer::Base.deliveries.count }.by(1)
		end
	end

	describe "on activation" do
		before do
			customer.save!
			customer.activate
		end
		it "activates the customer account" do
			expect(customer.reload.activated).to eq(true)
		end
	end
end
