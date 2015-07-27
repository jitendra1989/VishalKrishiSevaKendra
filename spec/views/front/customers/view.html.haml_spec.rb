require 'rails_helper'

RSpec.describe "front/customers/view", type: :view do
	let(:customer) { FactoryGirl.create(:customer) }

	it "renders product info" do
		assign(:current_customer, customer)
		render
		expect(rendered).to include(customer.name)
	end
end
