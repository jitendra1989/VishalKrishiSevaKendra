require 'rails_helper'

RSpec.describe "admin/orders/index", type: :view do

	let(:orders) { Order.all }

	it "renders attributes in <p>" do
		assign(:orders, orders)
		render
		expect(rendered).to match(/Order No/)
		expect(rendered).to match(/Order Date/)
		expect(rendered).to match(/Order Time/)
		expect(rendered).to match(/Customer/)
	end
end

