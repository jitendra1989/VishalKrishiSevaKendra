require 'rails_helper'

RSpec.describe "admin/specifications/edit", type: :view do

	let(:specification) { FactoryGirl.create(:specification) }

	it "renders new specification form" do
		assign(:specification, specification)
		render
		assert_select "form[action=?][method=?]", admin_specification_path(specification), "post" do
			assert_select "input#specification_name[name=?]", "specification[name]"
		end
	end
end
