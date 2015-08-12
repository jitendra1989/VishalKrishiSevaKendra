require 'rails_helper'

RSpec.describe Front::OrdersController, type: :controller do
  let(:customer) { FactoryGirl.create(:customer) }
  let(:online_cart) { FactoryGirl.create(:online_cart, customer: customer) }

  describe "logged in customer" do
    before do
      customer.activate
      customer_log_in customer
    end
    describe "GET #new" do
      let(:online_cart) { FactoryGirl.create(:online_cart) }
      it "redirects to cart page if no cart in session" do
        get :new
        expect(response).to redirect_to(edit_front_cart_url)
      end
      context 'with cart in session' do
        before do
          session[:online_cart_id] = online_cart.id
        end
        it "assigns a new order as @order" do
          get :new
          expect(assigns(:order)).to be_a_new(Order)
        end
        it "assigns a the cart in session as @cart" do
          get :new
          expect(assigns(:cart)).to eq(online_cart)
        end
      end
    end

    describe "POST #create" do
      context "without session being set" do
        it "redirects to the cart if no cart is in session" do
          post :create
          expect(response).to redirect_to(edit_front_cart_url)
        end
      end
      context "with session being set" do
        let!(:stock) { FactoryGirl.create(:stock, outlet: FactoryGirl.create(:online_outlet)) }
        before do
          online_cart.add_item(stock.product.id, stock.quantity)
          session[:online_cart_id] = online_cart.id
        end
        it "creates a new OnlineOrder" do
          expect {
            post :create
            }.to change(OnlineOrder, :count).by(1)
        end
        it "creates a new OrderItem" do
          expect {
            post :create
            }.to change(OnlineOrderItem, :count).by(1)
        end

        it "assigns a newly created order as @order" do
          post :create
          expect(assigns(:order)).to be_an(OnlineOrder)
          expect(assigns(:order)).to be_persisted
        end

        it "redirects to the order list" do
          post :create
          expect(response).to redirect_to(success_front_order_url)
        end
      end
    end

    describe "GET #payment" do
      it "redirects to the success page" do
        get :payment
        expect(response).to redirect_to(success_front_order_url)
      end
    end

    describe "GET #success" do
      let!(:online_order) { FactoryGirl.create(:online_order, customer: customer) }
      it "assigns a new order as @order" do
        get :success
        expect(assigns(:order)).to eq(online_order)
      end
    end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

  end

end
