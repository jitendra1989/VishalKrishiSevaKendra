require 'rails_helper'

RSpec.describe "admin/carts/index", type: :view do

	let(:carts) { Cart.all }

	it "renders attributes in <p>" do
		assign(:carts, carts)
		render
		expect(rendered).to include('Facilitator')
	end
end
