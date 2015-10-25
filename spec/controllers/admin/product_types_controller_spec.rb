require 'rails_helper'

RSpec.describe Admin::ProductTypesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:tax) { FactoryGirl.create(:tax) }
  let(:product_type) { FactoryGirl.create(:product_type) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:product_type) }

  describe "without login" do
    it "redirects to the login page" do
      get :index
      expect(response).to redirect_to(login_admin_users_url)
    end
  end

  describe 'after login' do
    before do
      log_in user
    end
    describe "GET #index" do
      it "assigns all product_types as @product_types" do
        get :index
        expect(assigns(:product_types)).to eq(ProductType.all)
      end
    end

    describe "GET #edit" do
      it "assigns the requested product_type as @product_type" do
        get :edit, id: product_type.id
        expect(assigns(:product_type)).to eq(product_type)
      end
    end

    describe "PUT #update" do
    before { product_type } # initialize
      context "with valid params" do
        it "assigns the requested product_type as @product_type" do
          put :update, id: product_type.id, product_type: valid_attributes
          expect(assigns(:product_type)).to eq(product_type)
        end
        describe "on successful update" do
          it "redirects to the product_type list" do
            put :update, id: product_type.id, product_type: valid_attributes
            expect(response).to redirect_to(admin_product_types_url)
          end
          it "renders the update js template" do
            put :update, id: product_type.id, product_type: valid_attributes, format: :js
            expect(response).to render_template(:update)
          end
        end

        it "creates a new ProductTypeTax" do
          expect {
            put :update, id: product_type.id, product_type: valid_attributes.merge(product_type_taxes_attributes: [FactoryGirl.attributes_for(:product_type_tax).merge(tax_id: tax.id)] )
            }.to change(ProductTypeTax, :count).by(1)
        end
      end
    end
  end

end
