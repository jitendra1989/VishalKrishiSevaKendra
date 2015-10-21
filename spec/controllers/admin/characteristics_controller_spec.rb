require 'rails_helper'

RSpec.describe Admin::CharacteristicsController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:characteristic) { FactoryGirl.create(:characteristic) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:characteristic) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:characteristic, name: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all characteristics as @characteristics" do
      get :index
      expect(assigns(:characteristics)).to eq(Characteristic.all)
    end
  end

  describe "GET #new" do
    it "assigns a new characteristic as @characteristic" do
      get :new
      expect(assigns(:characteristic)).to be_a_new(Characteristic)
    end
  end

  describe "GET #edit" do
    it "assigns the requested characteristic as @characteristic" do
      get :edit, id: characteristic.id
      expect(assigns(:characteristic)).to eq(characteristic)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Characteristic" do
        expect {
          post :create, characteristic: valid_attributes
        }.to change(Characteristic, :count).by(1)
      end

      it "assigns a newly created characteristic as @characteristic" do
        post :create, characteristic: valid_attributes
          expect(assigns(:characteristic)).to be_a(Characteristic)
          expect(assigns(:characteristic)).to be_persisted
      end

      it "redirects to the characteristic list" do
          post :create, characteristic: valid_attributes
          expect(response).to redirect_to(admin_characteristics_url)
      end
    end

    describe "with image" do
      let(:cv_file) { fixture_file_upload('test.pdf') }
      let(:png_file) { fixture_file_upload('test.png') }
      it "creates a new Specification image" do
        expect {
          post :create, characteristic: valid_attributes.merge(images_attributes: [ { name: png_file } ])
          }.to change(CharacteristicImage, :count).by(1)
      end
      it "uploads the image" do
        post :create, characteristic: valid_attributes.merge(images_attributes: [ { name: png_file } ])
        expect(response).to redirect_to(admin_characteristics_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved characteristic as @characteristic" do
        post :create, characteristic: invalid_attributes
        expect(assigns(:characteristic)).to be_a_new(Characteristic)
      end

      it "re-renders the 'new' template" do
          post :create, characteristic: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the attributes" do
          put :update, id: characteristic.id, characteristic: valid_attributes
          expect(assigns(:characteristic)).to have_attributes(valid_attributes)
      end

      it "assigns the requested characteristic as @characteristic" do
        put :update, id: characteristic.id, characteristic: valid_attributes
        expect(assigns(:characteristic)).to eq(characteristic)
      end

      it "redirects to the characteristic list" do
        put :update, id: characteristic.id, characteristic: valid_attributes
        expect(response).to redirect_to(admin_characteristics_url)
      end
    end

    context "with invalid params" do
      it "assigns the characteristic as @characteristic" do
        put :update, id: characteristic.id, characteristic: invalid_attributes
        expect(assigns(:characteristic)).to eq(characteristic)
      end

      it "re-renders the 'edit' template" do
        put :update, id: characteristic.id, characteristic: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:deletable_characteristic) { FactoryGirl.create(:characteristic) }
    it "destroys the requested characteristic" do
      expect {
        delete :destroy, id: deletable_characteristic.id
      }.to change(Characteristic, :count).by(-1)
    end

    it "redirects to the characteristics list" do
        delete :destroy, id: deletable_characteristic.id
        expect(response).to redirect_to(admin_characteristics_url)
    end
  end
end
