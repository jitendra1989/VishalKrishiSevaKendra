require 'rails_helper'

RSpec.describe Admin::OutletsController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:outlet) { FactoryGirl.create(:outlet) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:online_outlet) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:outlet, name: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all outlets as @outlets" do
      get :index
      expect(assigns(:outlets)).to eq(Outlet.all.page)
    end
  end

  describe "GET #new" do
    it "assigns a new outlet as @outlet" do
      get :new
      expect(assigns(:outlet)).to be_a_new(Outlet)
    end
  end

  describe "GET #edit" do
    it "assigns the requested outlet as @outlet" do
      get :edit, id: outlet.id
      expect(assigns(:outlet)).to eq(outlet)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Outlet" do
        expect {
          post :create, outlet: valid_attributes
        }.to change(Outlet, :count).by(1)
      end

      it "assigns a newly created outlet as @outlet" do
        post :create, outlet: valid_attributes
          expect(assigns(:outlet)).to be_an(Outlet)
          expect(assigns(:outlet)).to be_persisted
          expect(assigns(:outlet)).to have_attributes(valid_attributes)
      end

      it "redirects to the outlet list" do
          post :create, outlet: valid_attributes
          expect(response).to redirect_to(admin_outlets_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved outlet as @outlet" do
        post :create, outlet: invalid_attributes
        expect(assigns(:outlet)).to be_a_new(Outlet)
      end

      it "re-renders the 'new' template" do
          post :create, outlet: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested outlet" do
          put :update, id: outlet.id, outlet: valid_attributes
          expect(assigns(:outlet)).to have_attributes(valid_attributes)
      end

      it "assigns the requested outlet as @outlet" do
        put :update, id: outlet.id, outlet: valid_attributes
        expect(assigns(:outlet)).to eq(outlet)
        expect(assigns(:outlet)).to have_attributes(valid_attributes)
      end

      it "redirects to the outlet list" do
        put :update, id: outlet.id, outlet: valid_attributes
        expect(response).to redirect_to(admin_outlets_url)
      end
    end

    context "with invalid params" do
      it "assigns the outlet as @outlet" do
        put :update, id: outlet.id, outlet: invalid_attributes
        expect(assigns(:outlet)).to eq(outlet)
      end

      it "re-renders the 'edit' template" do
        put :update, id: outlet.id, outlet: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:delete_outlet) { FactoryGirl.create(:outlet) }
    it "destroys the requested outlet" do
      expect {
        delete :destroy, id: delete_outlet.id
      }.to change(Outlet, :count).by(-1)
    end

    it "redirects to the outlets list" do
        delete :destroy, id: delete_outlet.id
        expect(response).to redirect_to(admin_outlets_url)
    end
  end
end
