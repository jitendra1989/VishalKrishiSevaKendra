require 'rails_helper'

RSpec.describe "admin/products/index", type: :view do

	let(:products) { Product.all }

	it "renders attributes in <p>" do
		assign(:products, products)
		render
		expect(rendered).to match(/Name/)
		expect(rendered).to match(/Code/)
		expect(rendered).to match(/Description/)
		expect(rendered).to match(/Price/)
		expect(rendered).to match(/Active/)
	end
end
