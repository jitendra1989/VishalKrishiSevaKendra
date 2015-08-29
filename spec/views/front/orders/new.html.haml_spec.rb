require 'rails_helper'

RSpec.describe "front/orders/new", type: :view do
	let(:cart) { FactoryGirl.create(:online_cart) }
	let(:current_customer) { FactoryGirl.create(:customer) }

	before do
		cart.blocked_at = Time.zone.now
	end

	it "renders cart info" do
		assign(:cart, cart)
		assign(:order, OnlineOrder.new)
		assign(:current_customer, current_customer)
		render
		expect(rendered).to include('Order')
	end
end
