require 'rails_helper'

RSpec.describe "admin/customers/edit", type: :view do

	let(:customer) { FactoryGirl.create(:customer) }

	it "renders the edit customer form" do
		assign(:customer, customer)
		render
		assert_select "form[action=?][method=?]", admin_customer_path(customer), "post" do
			assert_select "input#customer_name[name=?]", "customer[name]"
			assert_select "input#customer_email[name=?]", "customer[email]"
			assert_select "input#customer_phone[name=?]", "customer[phone]"
		end
	end
end
