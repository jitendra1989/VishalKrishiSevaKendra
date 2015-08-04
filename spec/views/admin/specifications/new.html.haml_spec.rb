require 'rails_helper'

RSpec.describe "admin/specifications/new", type: :view do

	let(:specification) { Specification.new }

	it "renders new specification form" do
		assign(:specification, specification)
		render
		assert_select "form[action=?][method=?]", admin_specifications_path, "post" do
			assert_select "input#specification_name[name=?]", "specification[name]"
		end
	end
end
