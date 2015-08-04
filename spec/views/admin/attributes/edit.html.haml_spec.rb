require 'rails_helper'

RSpec.describe "admin/attributes/edit", type: :view do

	let(:attribute) { FactoryGirl.create(:attribute) }

	it "renders new attribute form" do
		assign(:attribute, attribute)
		render
		assert_select "form[action=?][method=?]", admin_attribute_path(attribute), "post" do
			assert_select "input#attribute_name[name=?]", "attribute[name]"
		end
	end
end
