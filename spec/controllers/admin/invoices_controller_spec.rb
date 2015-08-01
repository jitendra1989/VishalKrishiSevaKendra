require 'rails_helper'

RSpec.describe Admin::InvoicesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:customer) { FactoryGirl.create(:customer) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:invoice) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:invoice, amount: nil) }

  describe "without login" do
    it "redirects to the login page" do
      get :new, customer_id: customer.id
      expect(response).to redirect_to(login_admin_users_url)
    end
  end

  describe 'after login' do
    before do
      log_in user
    end
    describe "GET #new" do
      it "assigns a new invoice as @invoice to the customer" do
        get :new, customer_id: customer.id
        expect(assigns(:customer)).to eq(customer)
        expect(assigns(:invoice)).to be_a_new(Invoice)
        expect(assigns(:invoice).customer).to eq(customer)
      end
    end
  end

end
