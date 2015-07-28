require 'rails_helper'

RSpec.describe "front/customers/edit", type: :view do
	let(:customer) { FactoryGirl.create(:customer) }

	it "renders customer info" do
		assign(:current_customer, customer)
		render
		expect(rendered).to include(customer.name)
	end
end
