require 'rails_helper'

RSpec.describe Admin::BannersController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:banner) { FactoryGirl.create(:banner) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:banner) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:banner, name: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all banners as @banners" do
      get :index
      expect(assigns(:banners)).to eq(Banner.all.page)
    end
  end

  describe "GET #new" do
    it "assigns a new banner as @banner" do
      get :new
      expect(assigns(:banner)).to be_a_new(Banner)
    end
  end

  describe "GET #edit" do
    it "assigns the requested banner as @banner" do
      get :edit, id: banner.id
      expect(assigns(:banner)).to eq(banner)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Banner" do
        expect {
          post :create, banner: valid_attributes
        }.to change(Banner, :count).by(1)
      end

      it "assigns a newly created banner as @banner" do
        post :create, banner: valid_attributes
          expect(assigns(:banner)).to be_a(Banner)
          expect(assigns(:banner)).to be_persisted
      end

      it "redirects to the banner list" do
          post :create, banner: valid_attributes
          expect(response).to redirect_to(admin_banners_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved banner as @banner" do
        post :create, banner: invalid_attributes
        expect(assigns(:banner)).to be_a_new(Banner)
      end

      it "re-renders the 'new' template" do
          post :create, banner: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested banner" do
          put :update, id: banner.id, banner: valid_attributes
          expect(assigns(:banner).name).to eq(valid_attributes[:name])
      end

      it "assigns the requested banner as @banner" do
        put :update, id: banner.id, banner: valid_attributes
        expect(assigns(:banner)).to eq(banner)
      end

      it "redirects to the banner list" do
        put :update, id: banner.id, banner: valid_attributes
        expect(response).to redirect_to(admin_banners_url)
      end
    end

    context "with invalid params" do
      it "assigns the banner as @banner" do
        put :update, id: banner.id, banner: invalid_attributes
        expect(assigns(:banner)).to eq(banner)
      end

      it "re-renders the 'edit' template" do
        put :update, id: banner.id, banner: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:deletable_banner) { FactoryGirl.create(:banner) }
    it "destroys the requested banner" do
      expect {
        delete :destroy, id: deletable_banner.id
      }.to change(Banner, :count).by(-1)
    end

    it "redirects to the banners list" do
        delete :destroy, id: deletable_banner.id
        expect(response).to redirect_to(admin_banners_url)
    end
  end
end
