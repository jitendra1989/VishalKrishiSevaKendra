require 'rails_helper'

RSpec.describe Admin::InvoicesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:customer) { FactoryGirl.create(:customer) }
  let(:invoice) { FactoryGirl.create(:invoice) }
  let(:order) { FactoryGirl.create(:order) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:invoice) }

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

    describe "GET #index" do
      it "assigns all order invoices as @invoices" do
        get :index
        expect(assigns(:invoices)).to eq(Invoice.all)
      end
    end

    describe "GET #show" do
      it "assigns the requested invoice as @invoice" do
        get :show, id: invoice.id
        expect(assigns(:invoice)).to eq(invoice)
      end
    end

    describe "GET #gatepass" do
      it "assigns the requested invoice as @invoice" do
        get :gatepass, id: invoice.id, format: :pdf
        expect(assigns(:invoice)).to eq(invoice)
      end
    end

    describe "GET #dc" do
      it "assigns the requested invoice as @invoice" do
        get :dc, id: invoice.id, format: :pdf
        expect(assigns(:invoice)).to eq(invoice)
      end
    end

    describe "POST #create" do
      let(:order) { FactoryGirl.create(:order, customer: customer) }
      context "with valid params" do
        it "creates a new Invoice" do
          expect {
            post :create, customer_id: customer.id, invoice: valid_attributes.merge(order_ids: [order.id])
          }.to change(Invoice, :count).by(1)
        end

        it "assigns a newly created invoice as @invoice" do
          post :create, customer_id: customer.id, invoice: valid_attributes.merge(order_ids: [order.id])
          expect(assigns(:invoice)).to be_an(Invoice)
          expect(assigns(:invoice)).to be_persisted
        end

        it "redirects to the invoice list" do
          post :create, customer_id: customer.id, invoice: valid_attributes.merge(order_ids: [order.id])
          expect(response).to redirect_to(admin_invoices_url)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved invoice as @invoice" do
          post :create, customer_id: customer.id, invoice: {random: :value }
          expect(assigns(:invoice)).to be_a_new(Invoice)
        end

        it "re-renders the 'new' template" do
          post :create, customer_id: customer.id, invoice: {random: :value }
          expect(response).to render_template(:new)
        end
      end
    end
  end

end
