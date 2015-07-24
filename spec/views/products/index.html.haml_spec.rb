require 'rails_helper'

RSpec.describe "products/index", type: :view do
	let(:products) { Product.first(8) }

	it "renders products" do
		FactoryGirl.create(:product)
		assign(:products, products)
		render
		expect(rendered).to have_css('.product-box')
	end
end
