require 'rails_helper'

RSpec.describe Admin::SpecificationsController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:specification) { FactoryGirl.create(:specification) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:required_specification) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:specification, name: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all specifications as @specifications" do
      get :index
      expect(assigns(:specifications)).to eq(Specification.all)
    end
  end

  describe "GET #new" do
    it "assigns a new specification as @specification" do
      get :new
      expect(assigns(:specification)).to be_a_new(Specification)
    end
  end

  describe "GET #edit" do
    it "assigns the requested specification as @specification" do
      get :edit, id: specification.id
      expect(assigns(:specification)).to eq(specification)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Specification" do
        expect {
          post :create, specification: valid_attributes
        }.to change(Specification, :count).by(1)
      end

      it "assigns a newly created specification as @specification" do
        post :create, specification: valid_attributes
          expect(assigns(:specification)).to be_a(Specification)
          expect(assigns(:specification)).to be_persisted
      end

      it "redirects to the specification list" do
          post :create, specification: valid_attributes
          expect(response).to redirect_to(admin_specifications_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved specification as @specification" do
        post :create, specification: invalid_attributes
        expect(assigns(:specification)).to be_a_new(Specification)
      end

      it "re-renders the 'new' template" do
          post :create, specification: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the attributes" do
          put :update, id: specification.id, specification: valid_attributes
          expect(assigns(:specification)).to have_attributes(valid_attributes)
      end

      it "assigns the requested specification as @specification" do
        put :update, id: specification.id, specification: valid_attributes
        expect(assigns(:specification)).to eq(specification)
      end

      it "redirects to the specification list" do
        put :update, id: specification.id, specification: valid_attributes
        expect(response).to redirect_to(admin_specifications_url)
      end
    end

    context "with invalid params" do
      it "assigns the specification as @specification" do
        put :update, id: specification.id, specification: invalid_attributes
        expect(assigns(:specification)).to eq(specification)
      end

      it "re-renders the 'edit' template" do
        put :update, id: specification.id, specification: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:deletable_specification) { FactoryGirl.create(:specification) }
    it "destroys the requested specification" do
      expect {
        delete :destroy, id: deletable_specification.id
      }.to change(Specification, :count).by(-1)
    end

    it "redirects to the specifications list" do
        delete :destroy, id: deletable_specification.id
        expect(response).to redirect_to(admin_specifications_url)
    end
  end
end
