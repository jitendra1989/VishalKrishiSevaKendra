require 'rails_helper'

RSpec.describe Admin::OnlineTaxesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:online_tax) { FactoryGirl.create(:online_tax) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:online_tax) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:online_tax, name: nil) }
  before do
    log_in user
  end

  describe "GET #new" do
    it "assigns a new online_tax as @online_tax" do
      get :new
      expect(assigns(:online_tax)).to be_a_new(OnlineTax)
    end
  end

  describe "GET #edit" do
    it "assigns the requested online_tax as @online_tax" do
      get :edit, id: online_tax.id
      expect(assigns(:online_tax)).to eq(online_tax)
    end
  end

  describe "GET #index" do
    it "assigns all online_taxes as @online_taxes" do
      get :index
      expect(assigns(:online_taxes)).to eq(OnlineTax.all)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new OnlineTax" do
        expect {
          post :create, online_tax: valid_attributes
        }.to change(OnlineTax, :count).by(1)
      end

      it "assigns a newly created online_tax as @online_tax" do
        post :create, online_tax: valid_attributes
          expect(assigns(:online_tax)).to be_an(OnlineTax)
          expect(assigns(:online_tax)).to be_persisted
      end

      it "redirects to the online_tax list" do
          post :create, online_tax: valid_attributes
          expect(response).to redirect_to(admin_online_taxes_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved online_tax as @online_tax" do
        post :create, online_tax: invalid_attributes
        expect(assigns(:online_tax)).to be_a_new(OnlineTax)
      end

      it "re-renders the 'new' template" do
          post :create, online_tax: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested online_tax" do
          put :update, id: online_tax.id, online_tax: valid_attributes
          expect(assigns(:online_tax)).to have_attributes(valid_attributes)
      end

      it "assigns the requested online_tax as @online_tax" do
        put :update, id: online_tax.id, online_tax: valid_attributes
        expect(assigns(:online_tax)).to eq(online_tax)
      end

      it "redirects to the online_tax list" do
        put :update, id: online_tax.id, online_tax: valid_attributes
        expect(response).to redirect_to(admin_online_taxes_url)
      end
    end

    context "with invalid params" do
      it "assigns the online_tax as @online_tax" do
        put :update, id: online_tax.id, online_tax: invalid_attributes
        expect(assigns(:online_tax)).to eq(online_tax)
      end

      it "re-renders the 'edit' template" do
        put :update, id: online_tax.id, online_tax: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET #destroy" do
    let!(:delete_online_tax) { FactoryGirl.create(:online_tax) }
    it "destroys the requested online_tax" do
      expect {
        delete :destroy, id: delete_online_tax.id
      }.to change(OnlineTax, :count).by(-1)
    end

    it "redirects to the online_tax list" do
        delete :destroy, id: delete_online_tax.id
        expect(response).to redirect_to(admin_online_taxes_url)
    end
  end

end
