require 'rails_helper'

RSpec.describe Admin::ContentPagesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:content_page) { FactoryGirl.create(:content_page) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:content_page) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:content_page, title: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all content_pages as @content_pages" do
      get :index
      expect(assigns(:content_pages)).to eq(ContentPage.all)
    end
  end

  describe "GET #new" do
    it "assigns a new content_page as @content_page" do
      get :new
      expect(assigns(:content_page)).to be_a_new(ContentPage)
    end
  end

  describe "GET #edit" do
    it "assigns a new content_page as @content_page" do
      get :new
      expect(assigns(:content_page)).to be_a_new(ContentPage)
    end
  end

  describe "GET #create" do
    context "with valid params" do
      it "creates a new ContentPage" do
        expect {
          post :create, content_page: valid_attributes
        }.to change(ContentPage, :count).by(1)
      end

      it "assigns a newly created content_page as @content_page" do
        post :create, content_page: valid_attributes
          expect(assigns(:content_page)).to be_a(ContentPage)
          expect(assigns(:content_page)).to be_persisted
      end

      it "redirects to the content_page list" do
          post :create, content_page: valid_attributes
          expect(response).to redirect_to(admin_content_pages_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved content_page as @content_page" do
        post :create, content_page: invalid_attributes
        expect(assigns(:content_page)).to be_a_new(ContentPage)
      end

      it "re-renders the 'new' template" do
          post :create, content_page: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "GET #update" do
    context "with valid params" do
      it "updates the requested content_page" do
          put :update, id: content_page.id, content_page: valid_attributes
          expect(assigns(:content_page).title).to eq(valid_attributes[:title])
      end

      it "assigns the requested content_page as @content_page" do
        put :update, id: content_page.id, content_page: valid_attributes
        expect(assigns(:content_page)).to eq(content_page)
        expect(assigns(:content_page)).to have_attributes(valid_attributes)
      end

      it "redirects to the content_page list" do
        put :update, id: content_page.id, content_page: valid_attributes
        expect(response).to redirect_to(admin_content_pages_url)
      end
    end

    context "with invalid params" do
      it "assigns the content_page as @content_page" do
        put :update, id: content_page.id, content_page: invalid_attributes
        expect(assigns(:content_page)).to eq(content_page)
      end

      it "re-renders the 'edit' template" do
        put :update, id: content_page.id, content_page: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET #destroy" do
  let!(:deletable_content_page) { FactoryGirl.create(:content_page) }
    it "destroys the requested content_page" do
      expect {
        delete :destroy, id: deletable_content_page.id
      }.to change(ContentPage, :count).by(-1)
    end

    it "redirects to the content_pages list" do
        delete :destroy, id: deletable_content_page.id
        expect(response).to redirect_to(admin_content_pages_url)
    end
  end
end
