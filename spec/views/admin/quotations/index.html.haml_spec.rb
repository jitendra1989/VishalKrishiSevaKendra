require 'rails_helper'

RSpec.describe "admin/quotations/index", type: :view do
	let(:quotations) { Quotation.all }

		it "renders attributes in <p>" do
			assign(:quotations, quotations)
			render
			expect(rendered).to match(/Quotation No/)
			expect(rendered).to match(/Name/)
			expect(rendered).to match(/Mobile/)
		end
end