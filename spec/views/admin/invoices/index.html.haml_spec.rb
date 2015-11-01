require 'rails_helper'

RSpec.describe "admin/invoices/index", type: :view do

	let(:invoices) { Invoice.all.page(1) }

	it "renders attributes in <p>" do
		assign(:invoices, invoices)
		render
		expect(rendered).to match(/Invoice No/)
		expect(rendered).to match(/Invoice Date/)
		expect(rendered).to match(/Amount/)
		expect(rendered).to match(/Receipts/)
	end
end
