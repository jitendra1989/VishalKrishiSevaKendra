require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { FactoryGirl.create(:product) }
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
    it "assigns first 8 products as @products" do
      get :index
      expect(assigns(:products)).to eq(Product.first(8))
    end
  end
end
