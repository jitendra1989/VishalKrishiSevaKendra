require 'rails_helper'

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:category) { FactoryGirl.create(:category) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:category) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:category, name: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all categories as @categories" do
      get :index
      expect(assigns(:categories)).to eq(Category.roots)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Category" do
        expect {
          post :create, category: valid_attributes
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created category as @category" do
        post :create, category: valid_attributes
          expect(assigns(:category)).to be_an(Category)
          expect(assigns(:category)).to be_persisted
      end

      it "redirects to the category list" do
          post :create, category: valid_attributes
          expect(response).to redirect_to(admin_categories_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved category as @category" do
        post :create, category: invalid_attributes
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'new' template" do
          post :create, category: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested category" do
          put :update, id: category.id, category: valid_attributes
          expect(assigns(:category)).to have_attributes(valid_attributes)
      end

      it "assigns the requested category as @category" do
        put :update, id: category.id, category: valid_attributes
        expect(assigns(:category)).to eq(category)
      end

      it "redirects to the category list" do
        put :update, id: category.id, category: valid_attributes
        expect(response).to redirect_to(admin_categories_url)
      end
    end

    context "with invalid params" do
      it "assigns the category as @category" do
        put :update, id: category.id, category: invalid_attributes
        expect(assigns(:category)).to eq(category)
      end

      it "re-renders the 'edit' template" do
        put :update, id: category.id, category: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:delete_category) { FactoryGirl.create(:category) }
    it "destroys the requested category" do
      expect {
        delete :destroy, id: delete_category.id
      }.to change(Category, :count).by(-1)
    end

    it "redirects to the categorys list" do
        delete :destroy, id: delete_category.id
        expect(response).to redirect_to(admin_categories_url)
    end
  end

end
