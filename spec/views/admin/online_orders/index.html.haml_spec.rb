require 'rails_helper'

RSpec.describe "admin/online_orders/index", type: :view do

	let(:online_orders) { OnlineOrder.all }

	it "renders attributes in <p>" do
		assign(:online_orders, online_orders)
		render
		expect(rendered).to match(/Order No/)
		expect(rendered).to match(/Order Date/)
		expect(rendered).to match(/Order Time/)
		expect(rendered).to match(/Customer/)
	end
end

