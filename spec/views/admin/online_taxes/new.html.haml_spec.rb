require 'rails_helper'

RSpec.describe "admin/online_taxes/new", type: :view do

	let(:online_tax) { OnlineTax.new }

	it "renders the new online_tax form" do
		assign(:online_tax, online_tax)
		render
		assert_select "form[action=?][method=?]", admin_online_taxes_path, "post" do
			assert_select "input#online_tax_name[name=?]", "online_tax[name]"
			assert_select "input#online_tax_percentage[name=?]", "online_tax[percentage]"
		end
	end
end
