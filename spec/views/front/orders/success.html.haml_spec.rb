require 'rails_helper'

RSpec.describe "front/orders/success", type: :view do
	let(:order) { FactoryGirl.create(:online_order) }

	it "renders cart info" do
		assign(:order, order)
		render
		expect(rendered).to include('Order')
	end
end
