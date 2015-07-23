require 'rails_helper'

RSpec.describe Admin::StocksController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:product) { FactoryGirl.create(:product) }
  let(:stock) { FactoryGirl.create(:stock, product: product) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:stock) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:stock, new_quantity: nil) }
  before do
    log_in user
  end

  describe "GET #new" do
   it "assigns a new stock as @stock" do
      get :new, product_id: product.id
      expect(assigns(:product)).to eq(product)
      expect(assigns(:stock)).to be_a_new(Stock)
   end
  end

  describe "GET #index" do
    it "assigns all product stocks as @stocks" do
      get :index, product_id: product.id
      expect(assigns(:product)).to eq(product)
      expect(assigns(:stocks)).to eq(product.stocks)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Stock" do
        expect {
          post :create, product_id: product.id, stock: valid_attributes
        }.to change(Stock, :count).by(1)
      end

      it "assigns a newly created stock as @stock" do
        post :create, product_id: product.id, stock: valid_attributes
        expect(assigns(:product)).to eq(product)
        expect(assigns(:stock)).to be_a(Stock)
        expect(assigns(:stock)).to be_persisted
      end
      it "assigns a newly created stock to user outlet" do
        post :create, product_id: product.id, stock: valid_attributes
        expect(assigns(:stock).outlet).to eq(user.outlet)
      end

      it "redirects to the stock list" do
        post :create, product_id: product.id, stock: valid_attributes
        expect(response).to redirect_to(admin_product_stocks_url(product))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved stock as @stock" do
        post :create, product_id: product.id, stock: invalid_attributes
        expect(assigns(:stock)).to be_a_new(Stock)
      end

      it "re-renders the 'new' template" do
          post :create, product_id: product.id, stock: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

end
