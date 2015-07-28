require 'rails_helper'

RSpec.describe Front::CartsHelper, type: :helper do
	let(:online_cart) { FactoryGirl.create(:online_cart) }
	before do
		FactoryGirl.create_list(:online_cart_item, 3, cart: online_cart)
	end
	describe "online_cart_count" do
		it "returns 0 if no cart is set" do
			expect(helper.online_cart_count).to eq(0)
		end
		it "returns the count of items in cart if cart is initialised" do
			session[:online_cart_id] = online_cart.id
			expect(helper.online_cart_count).to eq(online_cart.items.count)
		end
	end
end
