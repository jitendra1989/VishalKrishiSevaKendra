require 'rails_helper'

RSpec.describe "admin/products/add_stock", type: :view do

	let(:user) { FactoryGirl.create(:user) }
	let(:product_group) { FactoryGirl.create(:product_group) }

	it "renders the new stocks form" do
		assign(:current_user, user)
		assign(:product_group, product_group)
		render
		assert_select "form[action=?][method=?]", admin_product_group_path(product_group), "post" do
		assert_select "input#product_group_new_quantity[name=?]", "product_group[new_quantity]"
		end
	end
end
