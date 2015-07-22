require 'rails_helper'

RSpec.describe "admin/products/index", type: :view do

	let(:products) { Product.all.page(params[:page]) }

	it "renders attributes in <p>" do
		assign(:products, products)
		render
		expect(rendered).to have_css('.product-container')
	end
end
