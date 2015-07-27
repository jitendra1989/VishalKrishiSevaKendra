require 'rails_helper'

RSpec.describe "front/customers/login", type: :view do

	it "renders product info" do
		assign(:customer, Customer.new)
		render
		expect(rendered).to have_css('.login-fields')
	end
end
