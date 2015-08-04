require 'rails_helper'

RSpec.describe Admin::AttributesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:attribute) { FactoryGirl.create(:attribute) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:required_attribute) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:attribute, name: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all attributes as @attributes" do
      get :index
      expect(assigns(:attributes)).to eq(Attribute.all)
    end
  end

  describe "GET #new" do
    it "assigns a new attribute as @attribute" do
      get :new
      expect(assigns(:attribute)).to be_a_new(Attribute)
    end
  end

  describe "GET #edit" do
    it "assigns the requested attribute as @attribute" do
      get :edit, id: attribute.id
      expect(assigns(:attribute)).to eq(attribute)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Attribute" do
        expect {
          post :create, attribute: valid_attributes
        }.to change(Attribute, :count).by(1)
      end

      it "assigns a newly created attribute as @attribute" do
        post :create, attribute: valid_attributes
          expect(assigns(:attribute)).to be_a(Attribute)
          expect(assigns(:attribute)).to be_persisted
      end

      it "redirects to the attribute list" do
          post :create, attribute: valid_attributes
          expect(response).to redirect_to(admin_attributes_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved attribute as @attribute" do
        post :create, attribute: invalid_attributes
        expect(assigns(:attribute)).to be_a_new(Attribute)
      end

      it "re-renders the 'new' template" do
          post :create, attribute: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested attribute" do
          put :update, id: attribute.id, attribute: valid_attributes
          expect(assigns(:attribute)).to have_attributes(valid_attributes)
      end

      it "assigns the requested attribute as @attribute" do
        put :update, id: attribute.id, attribute: valid_attributes
        expect(assigns(:attribute)).to eq(attribute)
      end

      it "redirects to the attribute list" do
        put :update, id: attribute.id, attribute: valid_attributes
        expect(response).to redirect_to(admin_attributes_url)
      end
    end

    context "with invalid params" do
      it "assigns the attribute as @attribute" do
        put :update, id: attribute.id, attribute: invalid_attributes
        expect(assigns(:attribute)).to eq(attribute)
      end

      it "re-renders the 'edit' template" do
        put :update, id: attribute.id, attribute: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:deletable_attribute) { FactoryGirl.create(:attribute) }
    it "destroys the requested attribute" do
      expect {
        delete :destroy, id: deletable_attribute.id
      }.to change(Attribute, :count).by(-1)
    end

    it "redirects to the attributes list" do
        delete :destroy, id: deletable_attribute.id
        expect(response).to redirect_to(admin_attributes_url)
    end
  end
end
