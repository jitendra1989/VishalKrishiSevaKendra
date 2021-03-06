require 'rails_helper'

RSpec.describe Front::ProductsController, type: :controller do
  let(:product) { FactoryGirl.create(:online_product) }
  describe "GET #show" do
    it "returns http success" do
      get :show, id: product.friendly_id
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "assigns first 24 products as @products" do
      get :index
      expect(assigns(:products)).to eq(Product.online.page(1).per(24))
      expect(assigns(:banners)).to eq(Banner.all)
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get :search, search: product.name
      expect(response).to have_http_status(:success)
    end
    it "redirects to home page if no matching query" do
      get :search, search: 'complexSearchHavingNoResults'
      expect(response).to redirect_to(front_root_url)
    end
  end
end
