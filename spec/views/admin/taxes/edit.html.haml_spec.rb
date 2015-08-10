require 'rails_helper'

RSpec.describe "admin/taxes/edit", type: :view do

	let(:tax) { FactoryGirl.create(:tax) }

	it "renders the edit tax form" do
		assign(:tax, tax)
		render
		assert_select "form[action=?][method=?]", admin_tax_path(tax), "post" do
			assert_select "input#tax_name[name=?]", "tax[name]"
			assert_select "input#tax_percentage[name=?]", "tax[percentage]"
		end
	end
end
