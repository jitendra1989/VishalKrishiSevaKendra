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
			it "uses an abandoned cart if exists" do
				abandoned_cart = FactoryGirl.create(:cart, user: user, outlet: user.outlet, customer: nil)
				post :add, product_id: product.id, quantity: 1
				expect(assigns(:cart)).to eq(abandoned_cart)
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
				expect(response).to redirect_to(edit_admin_cart_url(session[:cart_id]))
			end
		end

		describe "POST #update" do
			let(:product) { FactoryGirl.create(:product) }
			let!(:product_stock) { FactoryGirl.create(:stock, product: product, outlet: user.outlet) }

			before do
				cart.add_item(product, 1)
				session[:cart_id] = cart.id
			end

			it "updates the existing cart item quantity" do
				patch :update, id: cart.id, product_id: product.id, quantity: 1
				expect(cart.items.find_by(product: product).quantity).to eq(1)
			end
			it "assigns the cart as @cart" do
				patch :update, id: cart.id, product_id: product.id, quantity: 1
				expect(assigns(:cart)).to be_a(Cart)
			end

			it "redirects to the cart page" do
				patch :update, id: cart.id, product_id: product.id, quantity: 1
				expect(response).to redirect_to(edit_admin_cart_url(cart))
			end
		end

		describe "GET #edit" do
			it "assigns the active cart as @cart" do
				get :edit, id: cart.id
				expect(assigns(:cart)).to eq(cart)
			end
		end
	end
end