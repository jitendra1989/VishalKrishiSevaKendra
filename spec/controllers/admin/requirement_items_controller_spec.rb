require 'rails_helper'

RSpec.describe Admin::RequirementItemsController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:requirement) { FactoryGirl.create(:requirement, user: user, outlet: user.outlet) }
  let(:product) { FactoryGirl.create(:product) }
  let!(:product_stock) { FactoryGirl.create(:stock, product: product, outlet: user.outlet) }
  let(:specification) { FactoryGirl.create(:specification) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:requirement_item_customisation).merge(specification_id: specification.id) }

  before do
    requirement.products.create(product: product, quantity: 1)
  end
  describe "Without login" do
    it "redirects to the login page" do
      get :edit, id: requirement.products.first.id
      expect(response).to redirect_to(login_admin_users_url)
    end
  end

  describe "Logged in user" do
    let(:requirement_item) { requirement.products.first }
    before do
      log_in user
    end

    describe "GET #edit" do
      it "assigns the active requirement_item as @requirement_item" do
        get :edit, id: requirement_item.id
        expect(assigns(:requirement_item)).to eq(requirement_item)
        expect(assigns(:requirement)).to eq(requirement)
      end
    end

    describe "POST #update" do
      it "adds a customisation requirement item" do
        expect{
          patch :update, id: requirement_item.id, requirement_item: { customisations_attributes: [valid_attributes] }
        }.to change(RequirementItemCustomisation, :count).by(1)
      end
      it "assigns the requirement as @requirement" do
        patch :update, id: requirement_item.id, requirement_item: { customisations_attributes: [valid_attributes] }
        expect(assigns(:requirement_item)).to eq(requirement_item)
        expect(assigns(:requirement)).to eq(requirement_item.requirement)
      end

      it "redirects to the requirement page" do
        patch :update, id: requirement_item.id, requirement_item: { customisations_attributes: [valid_attributes] }
        expect(response).to redirect_to(edit_admin_requirement_item_url(requirement_item))
      end
    end

  end
end
