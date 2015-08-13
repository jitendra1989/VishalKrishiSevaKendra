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

    it "redirects to login if customer is valid but inactive" do
      post :login, customer: {email: customer.email,  password: customer.password }
      expect(response).to redirect_to(login_front_customer_url)
    end
    it "redirects to root if customer is valid and inactive" do
      customer.activate
      post :login, customer: {email: customer.email,  password: customer.password }
      expect(response).to redirect_to(front_root_url)
    end

    context 'activated customer' do
      before do
        customer.activate
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
        it "redirects to the customer login page" do
          post :create, customer: {email: valid_attributes[:email],  password: valid_attributes[:password],  password_confirmation: valid_attributes[:password] }
          expect(response).to redirect_to(login_front_customer_url)
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

  describe "Account activation process" do
    describe "GET activate" do
      it "activates customer if not logged in" do
        get :activate, { token: customer.activation_digest }
        expect(response).to redirect_to(edit_front_customer_url)
      end
      it "redirects to root url if invalid email" do
        get :activate, { token: 'faketoken' }
        expect(response).to redirect_to(login_front_customer_url)
      end
    end
  end

  describe "logged in customer" do
    before do
      customer.activate
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
          put :update, customer: valid_attributes
          expect(assigns(:current_customer)).to have_attributes(valid_attributes)
        end
        describe "redirect action" do
          it "redirects to the home page if cart is empty" do
            put :update, customer: valid_attributes
            expect(response).to redirect_to(front_root_url)
          end
          context 'with items in cart' do
            let(:online_cart) { FactoryGirl.create(:online_cart, customer: customer) }
            let!(:stock) { FactoryGirl.create(:stock, outlet: FactoryGirl.create(:online_outlet)) }
            before do
              online_cart.add_item(stock.product.id, stock.quantity)
            end
            it "redirects to the cart page if cart has items" do
              put :update, customer: valid_attributes
              expect(response).to redirect_to(edit_front_cart_url)
            end
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
