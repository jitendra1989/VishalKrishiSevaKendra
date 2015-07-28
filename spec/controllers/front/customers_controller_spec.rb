require 'rails_helper'

RSpec.describe Front::CustomersController, type: :controller do
  let(:customer) { FactoryGirl.create(:customer) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:customer) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:customer, email: nil ) }

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

    it "redirects to root if customer is valid" do
      post :login, customer: {email: customer.email,  password: customer.password }
      expect(response).to redirect_to(front_root_url)
    end

    it "redirects to root if customer is already logged in" do
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


  describe "POST #create" do
    context "with valid params" do
      it "creates a new Customer" do
        expect {
          post :create, customer: {email: valid_attributes[:email],  password: valid_attributes[:password],  password_confirmation: valid_attributes[:password] }
          }.to change(Customer, :count).by(1)
      end
      it "assigns a newly created customer as @customer" do
        post :create, customer: {email: valid_attributes[:email],  password: valid_attributes[:password],  password_confirmation: valid_attributes[:password] }
        expect(assigns(:customer)).to be_an(Customer)
        expect(assigns(:customer)).to be_persisted
      end
      describe "redirect action" do
        it "logs in the customer" do
          post :create, customer: {email: valid_attributes[:email],  password: valid_attributes[:password],  password_confirmation: valid_attributes[:password] }
          expect(session[:customer_id]).to eq(Customer.last.id)
        end
        it "redirects to the customer edit page" do
          post :create, customer: {email: valid_attributes[:email],  password: valid_attributes[:password],  password_confirmation: valid_attributes[:password] }
          expect(response).to redirect_to(edit_front_customer_url)
        end
      end
    end
    context "with invalid params" do
      it "assigns a newly created but unsaved customer as @customer" do
        post :create, customer: {email: valid_attributes[:email] }
        expect(assigns(:customer)).to be_a_new(Customer)
      end
      it "re-renders the 'new' template" do
        post :create, customer: {email: valid_attributes[:email] }
        expect(response).to render_template(:login)
      end
    end
  end

  describe "logged in customer" do
    before do
      customer_log_in customer
    end
    describe "GET #edit" do
      it "assigns the requested customer as @customer" do
        get :edit
        expect(assigns(:current_customer)).to eq(customer)
      end
    end
    describe "PUT #update" do
      context "with valid params" do
        it "updates the requested customer" do
          customer_log_in customer
          put :update, customer: valid_attributes
          expect(assigns(:current_customer)).to have_attributes(valid_attributes)
        end
        describe "redirect action" do
          it "redirects to the customer list" do
            put :update, customer: valid_attributes
            expect(response).to redirect_to(edit_front_customer_url)
          end
        end
      end
      context "with invalid params" do
        it "assigns the customer as @customer" do
          put :update, customer: invalid_attributes
          expect(assigns(:current_customer)).to eq(customer)
        end
        it "re-renders the 'edit' template" do
          put :update, customer: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end
  end
end
