require 'rails_helper'

RSpec.describe Admin::ReceiptsController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:order) { FactoryGirl.create(:order) }
  let(:receipt) { FactoryGirl.create(:receipt) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:receipt) }

  describe "without login" do
    it "redirects to the login page" do
      get :new, order_id: order.id
      expect(response).to redirect_to(login_admin_users_url)
    end
  end

  describe 'after login' do
    before do
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
  end
end
