require 'rails_helper'

RSpec.describe Admin::CartsController, type: :controller do
	let(:user) { FactoryGirl.create(:super_admin) }
	let(:cart) { FactoryGirl.create(:cart, user: user, outlet: user.outlet) }

	describe "Without login" do
		it "redirects to the login page" do
			get :index
			expect(response).to redirect_to(login_admin_users_url)
		end
	end

	describe "Logged in user" do
		before do
			log_in user
		end
		describe "GET #index" do
			it "assigns all store carts as @carts" do
				get :index
				expect(assigns(:carts)).to eq(Cart.where(outlet: user.outlet))
			end
		end

		describe "POST #add" do
			let(:product) { FactoryGirl.create(:product) }
			let!(:product_stock) { FactoryGirl.create(:stock, product: product, outlet: user.outlet) }

			it 'adds the product to the cart' do
				expect{
					post :add, product_id: product.id, quantity: 1
					}.to change(CartItem, :count).by(1)
			end
			it "creates a new cart if not exists" do
				expect{
					post :add, product_id: product.id, quantity: 1
					}.to change(Cart, :count).by(1)
			end
			it "user the existing cart if present" do
				session[:cart_id] = cart.id
				expect{
					post :add, product_id: product.id, quantity: 1
					}.to change(Cart, :count).by(0)
			end
			it "assigns the cart as @cart" do
				post :add, product_id: product.id, quantity: 1
				expect(assigns(:cart)).to be_a(Cart)
			end

			it "redirects to the cart page" do
				post :add, product_id: product.id, quantity: 1
				expect(response).to redirect_to(view_admin_carts_url)
			end
		end

		describe "GET #view" do
			it "assigns the active cart as @cart" do
				session[:cart_id] = cart.id
				get :view
				expect(assigns(:cart)).to eq(cart)
			end
			it "redirects to the index page if no cart is active" do
				get :view
				expect(response).to redirect_to(admin_carts_url)
			end
		end
	end
end