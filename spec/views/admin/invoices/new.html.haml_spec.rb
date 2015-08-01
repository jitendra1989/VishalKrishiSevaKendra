require 'rails_helper'
RSpec.describe "admin/invoices/new", type: :view do

	let(:customer) { FactoryGirl.create(:customer) }

	it "renders attributes in <p>" do
		assign(:customer, customer)
		assign(:invoice, Invoice.new)
		render
		expect(rendered).to match(/Name/)
		expect(rendered).to match(/Address/)
	end
end
