require 'rails_helper'

RSpec.describe "admin/categories/new", type: :view do

	let(:category) { Category.new }

	it "renders new category form" do
		assign(:category, category)
		render
		assert_select "form[action=?][method=?]", admin_categories_path, "post" do
			assert_select "input#category_name[name=?]", "category[name]"
		end
	end
end
