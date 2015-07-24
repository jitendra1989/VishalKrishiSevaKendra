require 'rails_helper'

RSpec.describe "admin/products/index", type: :view do

	let(:products) { Product.all.page(params[:page]) }
	let(:user) { FactoryGirl.create(:user) }

	it "renders attributes in <p>" do
		FactoryGirl.create(:product)
		assign(:products, products)
		assign(:current_user, user)
		render
		expect(rendered).to have_css('.product-container')
	end
end
