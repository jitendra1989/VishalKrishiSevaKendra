require 'rails_helper'

RSpec.describe "front/orders/new", type: :view do
	let(:cart) { FactoryGirl.create(:online_cart) }

	it "renders cart info" do
		assign(:cart, cart)
		assign(:order, OnlineOrder.new)
		render
		expect(rendered).to include('Order')
	end
end
