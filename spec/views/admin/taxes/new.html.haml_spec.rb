require 'rails_helper'

RSpec.describe "admin/taxes/new", type: :view do

	let(:tax) { Tax.new }

	it "renders the new tax form" do
		assign(:tax, tax)
		render
		assert_select "form[action=?][method=?]", admin_taxes_path, "post" do
			assert_select "input#tax_name[name=?]", "tax[name]"
			assert_select "input#tax_percentage[name=?]", "tax[percentage]"
		end
	end
end
