require 'rails_helper'

RSpec.describe "admin/attributes/new", type: :view do

	let(:attribute) { Attribute.new }

	it "renders new attribute form" do
		assign(:attribute, attribute)
		render
		assert_select "form[action=?][method=?]", admin_attributes_path, "post" do
			assert_select "input#attribute_name[name=?]", "attribute[name]"
		end
	end
end
