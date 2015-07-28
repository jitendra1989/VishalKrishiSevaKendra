require 'rails_helper'

RSpec.describe "front/customers/login", type: :view do
	let(:customer) { FactoryGirl.create(:customer) }

	it "renders customer info" do
		assign(:customer, Customer.new)
		render
		expect(rendered).to have_css('.login-fields')
	end
end
