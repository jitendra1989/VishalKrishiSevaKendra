require 'rails_helper'

RSpec.describe Admin::CartItemsController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:cart) { FactoryGirl.create(:cart, user: user, outlet: user.outlet) }
  let(:product) { FactoryGirl.create(:product) }
  let!(:product_stock) { FactoryGirl.create(:stock, product: product, outlet: user.outlet) }
  let(:specification) { FactoryGirl.create(:specification) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:cart_item_customisation).merge(specification_id: specification.id) }

  before do
    cart.add_item(product, 1)
  end
  describe "Without login" do
    it "redirects to the login page" do
      get :edit, id: cart.items.first.id
      expect(response).to redirect_to(login_admin_users_url)
    end
  end

  describe "Logged in user" do
    let(:cart_item) { cart.items.first }
    before do
      log_in user
      session[:cart_id] = cart.id
    end

    describe "GET #edit" do
      it "assigns the active cart_item as @cart_item" do
        get :edit, id: cart_item.id
        expect(assigns(:cart_item)).to eq(cart_item)
        expect(assigns(:cart)).to eq(cart)
      end
    end

    describe "POST #update" do
      it "adds a customisation cart item" do
        expect{
          patch :update, id: cart_item.id, cart_item: { customisations_attributes: [valid_attributes] }
        }.to change(CartItemCustomisation, :count).by(1)
      end
      it "assigns the cart as @cart" do
        patch :update, id: cart_item.id, cart_item: { customisations_attributes: [valid_attributes] }
        expect(assigns(:cart_item)).to eq(cart_item)
        expect(assigns(:cart)).to eq(cart_item.cart)
      end

      it "redirects to the cart page" do
        patch :update, id: cart_item.id, cart_item: { customisations_attributes: [valid_attributes] }
        expect(response).to redirect_to(edit_admin_cart_item_url(cart_item))
      end
    end

  end
end
