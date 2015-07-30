require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:order) { FactoryGirl.create(:order) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:order) }

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
      it "assigns all store orders as @orders" do
        get :index
        expect(assigns(:orders)).to eq(Order.where(outlet: user.outlet))
      end
    end

    describe "GET #show" do
      it "assigns the requested order as @order" do
        get :show, id: order.id
        expect(assigns(:order)).to eq(order)
      end
    end

    describe "POST #create" do
      let(:cart) { FactoryGirl.create(:cart, user: user, outlet: user.outlet) }
      context "without session being set" do
        it "redirects to the cart if no cart is in session" do
          post :create, order: valid_attributes
          expect(response).to redirect_to(admin_carts_url)
        end
      end
      context "with session being set" do
        let!(:stock) { FactoryGirl.create(:stock, outlet: user.outlet) }
        before do
          cart.add_item(stock.product.id, stock.quantity)
          session[:cart_id] = cart.id
        end
        it "creates a new Order" do
          expect {
            post :create, order: valid_attributes
            }.to change(Order, :count).by(1)
        end
        it "creates a new OrderItem" do
          expect {
            post :create, order: valid_attributes
            }.to change(OrderItem, :count).by(1)
        end

        it "assigns a newly created order as @order" do
          post :create, order: valid_attributes
          expect(assigns(:order)).to be_an(Order)
          expect(assigns(:order)).to be_persisted
        end

        it "redirects to the order list" do
          post :create, order: valid_attributes
          expect(response).to redirect_to(admin_orders_url)
        end
      end
    end
  end
end
