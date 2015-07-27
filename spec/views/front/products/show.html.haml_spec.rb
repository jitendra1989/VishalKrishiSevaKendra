require 'rails_helper'

RSpec.describe "front/products/show", type: :view do
	let(:product) { FactoryGirl.create(:product) }

	it "renders product info" do
		assign(:product, product)
		render
		expect(rendered).to include(product.name)
	end
end
