require 'rails_helper'

RSpec.describe Admin::TaxesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:tax) { FactoryGirl.create(:tax) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:tax) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:tax, name: nil) }
  before do
    log_in user
  end

  describe "GET #new" do
    it "assigns a new tax as @tax" do
      get :new
      expect(assigns(:tax)).to be_a_new(Tax)
    end
    describe 'new child tax' do
      it "returns http success" do
        get :new, tax_id: tax.id
        expect(assigns(:tax)).to be_a_new(Tax)
        expect(assigns(:tax).parent).to eq(tax)
      end
   end
  end

  describe "GET #edit" do
    it "assigns the requested tax as @tax" do
      get :edit, id: tax.id
      expect(assigns(:tax)).to eq(tax)
    end
  end

  describe "GET #index" do
    it "assigns all root taxes as @taxes" do
      get :index
      expect(assigns(:taxes)).to eq(Tax.roots)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tax" do
        expect {
          post :create, tax: valid_attributes
        }.to change(Tax, :count).by(1)
      end

      it "assigns a newly created tax as @tax" do
        post :create, tax: valid_attributes
          expect(assigns(:tax)).to be_an(Tax)
          expect(assigns(:tax)).to be_persisted
      end

      it "redirects to the tax list" do
          post :create, tax: valid_attributes
          expect(response).to redirect_to(admin_taxes_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved tax as @tax" do
        post :create, tax: invalid_attributes
        expect(assigns(:tax)).to be_a_new(Tax)
      end

      it "re-renders the 'new' template" do
          post :create, tax: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe 'POST #create child tax' do
    before do
      tax.reload
    end
    it "creates a new Tax" do
      expect {
        post :create, tax_id: tax.id, tax: valid_attributes
      }.to change(Tax, :count).by(1)
    end

    it "assigns a newly created tax as @tax" do
      post :create, tax_id: tax.id, tax: valid_attributes
        expect(assigns(:tax).parent).to eq(tax)
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested tax" do
          put :update, id: tax.id, tax: valid_attributes
          expect(assigns(:tax)).to have_attributes(valid_attributes)
      end

      it "assigns the requested tax as @tax" do
        put :update, id: tax.id, tax: valid_attributes
        expect(assigns(:tax)).to eq(tax)
      end

      it "redirects to the tax list" do
        put :update, id: tax.id, tax: valid_attributes
        expect(response).to redirect_to(admin_taxes_url)
      end
    end

    context "with invalid params" do
      it "assigns the tax as @tax" do
        put :update, id: tax.id, tax: invalid_attributes
        expect(assigns(:tax)).to eq(tax)
      end

      it "re-renders the 'edit' template" do
        put :update, id: tax.id, tax: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET #destroy" do
    let!(:delete_tax) { FactoryGirl.create(:tax) }
    it "destroys the requested tax" do
      expect {
        delete :destroy, id: delete_tax.id
      }.to change(Tax, :count).by(-1)
    end

    it "redirects to the tax list" do
        delete :destroy, id: delete_tax.id
        expect(response).to redirect_to(admin_taxes_url)
    end
  end

end
