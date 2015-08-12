require 'rails_helper'

RSpec.describe "front/products/index", type: :view do
	let(:products) { Product.online.page(1).per(24) }

	it "renders products" do
		view.lookup_context.prefixes << "front/application" # https://github.com/rails/rails/issues/5213
		FactoryGirl.create(:online_product)
		assign(:products, products)
		assign(:banners, Banner.all)
		render
		expect(rendered).to have_css('.product-box')
	end
end
