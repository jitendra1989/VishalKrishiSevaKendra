require 'rails_helper'

RSpec.describe "admin/online_taxes/edit", type: :view do

	let(:online_tax) { FactoryGirl.create(:online_tax) }

	it "renders the new online_tax form" do
		assign(:online_tax, online_tax)
		render
		assert_select "form[action=?][method=?]", admin_online_tax_path(online_tax), "post" do
			assert_select "input#online_tax_name[name=?]", "online_tax[name]"
			assert_select "input#online_tax_percentage[name=?]", "online_tax[percentage]"
		end
	end
end
