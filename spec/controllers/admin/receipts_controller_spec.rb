require 'rails_helper'

RSpec.describe Admin::ReceiptsController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:order) { FactoryGirl.create(:order) }
  let(:receipt) { FactoryGirl.create(:receipt, order: order) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:receipt) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:receipt, amount: nil) }

  describe "without login" do
    it "redirects to the login page" do
      get :new, order_id: order.id
      expect(response).to redirect_to(login_admin_users_url)
    end
  end

  describe 'after login' do
    before do
      order.items << FactoryGirl.create_list(:order_item, 2, order: nil)
      log_in user
    end
    describe "GET #new" do
      it "assigns a new receipt as @receipt to the order" do
        get :new, order_id: order.id
        expect(assigns(:order)).to eq(order)
        expect(assigns(:receipt)).to be_a_new(Receipt)
        expect(assigns(:receipt).order).to eq(order)
      end
    end

    describe "GET #index" do
      it "assigns all order receipts as @receipts" do
        get :index, order_id: order.id
        expect(assigns(:order)).to eq(order)
        expect(assigns(:receipts)).to eq(order.receipts)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new receipt" do
          expect {
            post :create, order_id: order.id, receipt: valid_attributes
            }.to change(Receipt, :count).by(1)
        end
        it "assigns a newly created receipt as @receipt" do
          post :create, order_id: order.id, receipt: valid_attributes
          expect(assigns(:order)).to eq(order)
          expect(assigns(:receipt)).to be_a(Receipt)
          expect(assigns(:receipt)).to be_persisted
        end
        it "redirects to the receipt list" do
          post :create, order_id: order.id, receipt: valid_attributes
          expect(response).to redirect_to(admin_orders_url)
        end
      end
      context "with invalid params" do
        it "assigns a newly created but unsaved receipt as @receipt" do
          post :create, order_id: order.id, receipt: invalid_attributes
          expect(assigns(:receipt)).to be_a_new(Receipt)
        end
        it "re-renders the 'new' template" do
          post :create, order_id: order.id, receipt: invalid_attributes
          expect(response).to render_template(:new)
        end
      end
    end
  end

end
