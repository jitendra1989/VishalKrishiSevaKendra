require 'rails_helper'

RSpec.describe "admin/customers/index", type: :view do

	let(:customers) { Customer.all }

	it "renders attributes in <p>" do
		assign(:customers, customers)
		render
		expect(rendered).to match(/Name/)
		expect(rendered).to match(/Address/)
		expect(rendered).to match(/Mobile/)
		expect(rendered).to match(/Email/)
	end
end
