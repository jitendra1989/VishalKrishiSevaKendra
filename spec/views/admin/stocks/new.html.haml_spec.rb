require 'rails_helper'

RSpec.describe "admin/stocks/new", type: :view do

	let(:user) { FactoryGirl.create(:user) }
	let(:product) { FactoryGirl.create(:product) }
	let(:stock) { product.stocks.build }

	it "renders the new stocks form" do
		assign(:current_user, user)
		assign(:stock, stock)
		assign(:product, product)
		render
		assert_select "form[action=?][method=?]", admin_product_stocks_path(product), "post" do
		assert_select "input#stock_new_quantity[name=?]", "stock[new_quantity]"
		end
	end
end
