require 'rails_helper'

RSpec.describe Admin::PagesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:page) { FactoryGirl.create(:content_page) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:content_page) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:content_page, title: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all pages as @pages" do
      get :index
      expect(assigns(:pages)).to eq(ContentPage.all)
    end
  end

  describe "GET #new" do
    it "assigns a new page as @page" do
      get :new
      expect(assigns(:page)).to be_a_new(ContentPage)
    end
  end

  describe "GET #edit" do
    it "assigns the requested page as @page" do
      get :edit, id: page.id
      expect(assigns(:page)).to eq(page)
    end
  end

  describe "GET #create" do
    context "with valid params" do
      it "creates a new ContentPage" do
        expect {
          post :create, content_page: valid_attributes
        }.to change(ContentPage, :count).by(1)
      end

      it "assigns a newly created page as @page" do
        post :create, content_page: valid_attributes
          expect(assigns(:page)).to be_a(ContentPage)
          expect(assigns(:page)).to be_persisted
      end

      it "redirects to the page list" do
          post :create, content_page: valid_attributes
          expect(response).to redirect_to(admin_pages_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved page as @page" do
        post :create, content_page: invalid_attributes
        expect(assigns(:page)).to be_a_new(ContentPage)
      end

      it "re-renders the 'new' template" do
          post :create, content_page: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "GET #update" do
    context "with valid params" do
      it "assigns the requested page as @page" do
        put :update, id: page.id, content_page: valid_attributes
        expect(assigns(:page)).to eq(page)
      end

      it "redirects to the page list" do
        put :update, id: page.id, content_page: valid_attributes
        expect(response).to redirect_to(admin_pages_url)
      end
    end

    context "with invalid params" do
      it "assigns the page as @page" do
        put :update, id: page.id, content_page: invalid_attributes
        expect(assigns(:page)).to eq(page)
      end

      it "re-renders the 'edit' template" do
        put :update, id: page.id, content_page: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET #destroy" do
    let!(:delete_page) { FactoryGirl.create(:content_page) }
    it "destroys the requested page" do
      expect {
        delete :destroy, id: delete_page.id
      }.to change(ContentPage, :count).by(-1)
    end

    it "redirects to the pages list" do
        delete :destroy, id: delete_page.id
        expect(response).to redirect_to(admin_pages_url)
    end
  end

end
