require 'rails_helper'

RSpec.describe Admin::OrderItemCustomisationsController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:order_item_customisation) { FactoryGirl.create(:order_item_customisation) }

  describe "without login" do
    it "redirects to the login page" do
      get :index
      expect(response).to redirect_to(login_admin_users_url)
    end
  end

  describe " logged in user" do
    before do
      log_in user
    end
    describe "GET #index" do
      it "assigns all order_item_customisations as @order_item_customisations" do
        get :index
        expect(assigns(:order_item_customisations)).to eq(OrderItemCustomisation.all)
      end
    end

    describe "GET #edit" do
      it "assigns the requested order_item_customisation as @order_item_customisation" do
        get :edit, id: order_item_customisation.id
        expect(assigns(:order_item_customisation)).to eq(order_item_customisation)
      end
    end

    describe "PUT #update" do
      let(:status) { OrderItemCustomisation.statuses.to_a.sample[0] }
      context "with valid params" do
        it "updates the requested order_item_customisation" do
            put :update, id: order_item_customisation.id, order_item_customisation: { status: status }
            expect(assigns(:order_item_customisation).status).to eq(status)
        end

        it "assigns the requested order_item_customisation as @order_item_customisation" do
          put :update, id: order_item_customisation.id, order_item_customisation: { status: status }
          expect(assigns(:order_item_customisation)).to eq(order_item_customisation)
        end

        it "redirects to the order_item_customisation list" do
          put :update, id: order_item_customisation.id, order_item_customisation: { status: status }
          expect(response).to redirect_to(admin_workshop_index_url)
        end
      end
    end
  end

end
