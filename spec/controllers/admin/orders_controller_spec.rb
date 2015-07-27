require 'rails_helper'

RSpec.describe Admin::OrdersController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
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

        it "assigns a newly created quotation as @quotation" do
          post :create, order: valid_attributes
          expect(assigns(:order)).to be_an(Order)
          expect(assigns(:order)).to be_persisted
        end

        it "redirects to the order list" do
          post :create, order: valid_attributes
          expect(response).to redirect_to(admin_orders_url)
        end
      end

      # context "with invalid params" do
      #   it "assigns a newly created but unsaved quotation as @quotation" do
      #     post :create, customer_id: customer.id, quotation: invalid_attributes
      #     expect(assigns(:quotation)).to be_a_new(Quotation)
      #   end
      #   it "re-renders the 'new' template" do
      #     post :create, customer_id: customer.id, quotation: invalid_attributes
      #     expect(response).to render_template("new")
      #   end
      # end
    end

    # describe "GET #show" do
    #   it "returns http success" do
    #     get :show
    #     expect(response).to have_http_status(:success)
    #   end
    # end

    # describe "GET #edit" do
    #   it "returns http success" do
    #     get :edit
    #     expect(response).to have_http_status(:success)
    #   end
    # end
  end
end
