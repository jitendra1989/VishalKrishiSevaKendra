require 'rails_helper'

RSpec.describe Admin::CartsHelper, type: :helper do
	let(:cart) { FactoryGirl.create(:cart) }
	before do
		FactoryGirl.create_list(:cart_item, 3, cart: cart)
	end
	describe "cart_count" do
		it "returns 0 if no cart is set" do
			expect(helper.cart_count).to eq(0)
		end
		it "returns the count of items in cart if cart is initialised" do
			session[:cart_id] = cart.id
			expect(helper.cart_count).to eq(cart.items.count)
		end
	end
	describe "active_cart_url" do
		it 'returns the carts index page if no session is set' do
			expect(helper.active_cart_url).to eq(admin_carts_path)
		end
		it "returns the count of items in cart if cart is initialised" do
			session[:cart_id] = cart.id
			expect(helper.active_cart_url).to eq(edit_admin_cart_path(cart))
		end
	end
end
