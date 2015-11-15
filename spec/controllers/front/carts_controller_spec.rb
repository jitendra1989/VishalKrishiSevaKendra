require 'rails_helper'

RSpec.describe Front::CartsController, type: :controller do

  let(:product) { FactoryGirl.create(:product) }
  let(:online_cart) { FactoryGirl.create(:online_cart) }
  let!(:product_stock) { FactoryGirl.create(:stock, product: product, outlet: FactoryGirl.create(:online_outlet)) }

  describe "POST #add" do
    it 'adds the product to the cart' do
      expect{
        post :add, product_id: product.id, quantity: 1
        }.to change(OnlineCartItem, :count).by(1)
    end
    it "creates a new cart if not exists" do
      expect{
        post :add, product_id: product.id, quantity: 1
        }.to change(OnlineCart, :count).by(1)
    end
    it "user the existing cart if present" do
      session[:cart_id] = online_cart.id
      expect{
        post :add, product_id: product.id, quantity: 1
        }.to change(Cart, :count).by(0)
    end
    it "redirects to the cart page" do
      post :add, product_id: product.id, quantity: 1
      expect(response).to redirect_to(edit_front_cart_url)
    end
  end

  describe "GET #edit" do
    it "assigns the active cart as @cart" do
      session[:online_cart_id] = online_cart.id
      get :edit
      expect(assigns(:cart)).to eq(online_cart)
    end
  end

  describe "POST #update" do
    before do
      online_cart.add_item(product.id, 10)
      session[:online_cart_id] = online_cart.id
    end

    it "updates the existing cart item quantity" do
      patch :update, product_id: product.id, quantity: 1
      expect(online_cart.items.find_by(product: product).quantity).to eq(1)
    end

    it "redirects to the cart page" do
      patch :update, product_id: product.id, quantity: 1
      expect(response).to redirect_to(edit_front_cart_url)
    end
  end

  describe "DELETE #remove" do
    before do
      online_cart.add_item(product.id, 10)
      session[:online_cart_id] = online_cart.id
    end
    it "redirects to the cart page" do
      delete :remove, product_id: product.id
      expect(response).to redirect_to(edit_front_cart_url)
    end
    it "removes the selected item from the cart" do
      delete :remove, product_id: product.id
      expect(online_cart.reload.items.where(product: product).size).to eq(0)
    end
  end

end
