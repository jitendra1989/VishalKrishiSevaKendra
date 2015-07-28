require 'rails_helper'

RSpec.describe "front/products/show", type: :view do
	let(:product) { FactoryGirl.create(:product) }
	it "renders product info" do
		view.lookup_context.prefixes << "front/application" # https://github.com/rails/rails/issues/5213
		assign(:product, product)
		render
		expect(rendered).to include(product.name)
	end
end
