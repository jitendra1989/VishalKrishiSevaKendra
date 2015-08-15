require 'rails_helper'

RSpec.describe Admin::OnlineOrdersController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:order) { FactoryGirl.create(:online_order) }

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
      it "assigns all online orders as @orders" do
        get :index
        expect(assigns(:online_orders)).to eq(OnlineOrder.all)
      end
    end

    describe "GET #show" do
      it "assigns the requested online order as @order" do
        get :show, id: order.id
        expect(assigns(:online_order)).to eq(order)
      end
    end
  end
end
