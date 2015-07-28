require 'rails_helper'

RSpec.describe "front/products/index", type: :view do
	let(:products) { Product.first(8) }

	it "renders products" do
		view.lookup_context.prefixes << "front/application" # https://github.com/rails/rails/issues/5213
		FactoryGirl.create(:product)
		assign(:products, products)
		render
		expect(rendered).to have_css('.product-box')
	end
end
