require 'rails_helper'

RSpec.describe "admin/customers/new", type: :view do
	let(:customer) { Customer.new }

	it "renders the new customer form" do
		assign(:customer, customer)
		render
		assert_select "form[action=?][method=?]", admin_customers_path, "post" do
			assert_select "input#customer_name[name=?]", "customer[name]"
			assert_select "input#customer_password[name=?]", "customer[password]"
			assert_select "input#customer_password_confirmation[name=?]", "customer[password_confirmation]"
			assert_select "input#customer_email[name=?]", "customer[email]"
			assert_select "input#customer_phone[name=?]", "customer[phone]"
		end
	end

end
