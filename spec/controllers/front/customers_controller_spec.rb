require 'rails_helper'

RSpec.describe Front::CustomersController, type: :controller do
  let(:customer) { FactoryGirl.create(:customer) }

  describe 'GET #login' do
    it "assigns a new customer as @customer" do
      get :login
      expect(response).to render_template(:login)
        expect(assigns(:customer)).to be_a_new(Customer)
    end

    it "renders login if customer is invalid" do
      post :login, customer: {email: 'sometext',  password: 'dodo' }
      expect(response).to render_template(:login)
      expect(flash.now[:danger]).to include('Invalid')
    end

    it "redirects to dashboard if customer is valid" do
      post :login, customer: {email: customer.email,  password: customer.password }
      expect(response).to redirect_to(front_root_url)
    end

    it "redirects to dashboard if customer is already logged in" do
      customer_log_in customer
      get :login
      expect(response).to redirect_to(front_root_url)
    end

    it "redirects customer to login page on logout" do
      customer_log_in customer
      delete :logout
      expect(response).to redirect_to(front_root_url)
    end
  end

  describe "GET #edit" do
    it "assigns the requested customer as @customer" do
      get :edit, id: customer.id
      expect(assigns(:customer)).to eq(customer)
    end
  end

end
