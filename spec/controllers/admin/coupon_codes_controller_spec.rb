require 'rails_helper'

RSpec.describe Admin::CouponCodesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:coupon_code) { FactoryGirl.create(:coupon_code) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:coupon_code) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:coupon_code, code: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all coupon_codes as @coupon_codes" do
      get :index
      expect(assigns(:coupon_codes)).to eq(CouponCode.all)
    expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "assigns a new coupon_code as @coupon_code" do
        get :new
        expect(assigns(:coupon_code)).to be_a_new(CouponCode)
    end
  end

  describe "GET #edit" do
   it "assigns the requested coupon_code as @coupon_code" do
      get :edit, id: coupon_code.id
      expect(assigns(:coupon_code)).to eq(coupon_code)
    end
  end

  describe "POST #create" do
      context "with valid params" do
        it "creates a new CouponCode" do
          expect {
            post :create, coupon_code: valid_attributes
          }.to change(CouponCode, :count).by(1)
        end

        it "assigns a newly created coupon_code as @coupon_code" do
          post :create, coupon_code: valid_attributes
            expect(assigns(:coupon_code)).to be_an(CouponCode)
            expect(assigns(:coupon_code)).to be_persisted
        end

        it "redirects to the coupon_code list" do
            post :create, coupon_code: valid_attributes
            expect(response).to redirect_to(admin_coupon_codes_url)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved coupon_code as @coupon_code" do
          post :create, coupon_code: invalid_attributes
          expect(assigns(:coupon_code)).to be_a_new(CouponCode)
        end

        it "re-renders the 'new' template" do
            post :create, coupon_code: invalid_attributes
            expect(response).to render_template("new")
        end
      end
    end

  describe "PUT #update" do
    context "with valid params" do
      it "updates the requested coupon_code" do
          put :update, id: coupon_code.id, coupon_code: valid_attributes
          expect(assigns(:coupon_code)).to have_attributes(valid_attributes)
      end

      it "assigns the requested coupon_code as @coupon_code" do
        put :update, id: coupon_code.id, coupon_code: valid_attributes
        expect(assigns(:coupon_code)).to eq(coupon_code)
      end

      it "redirects to the coupon_code list" do
        put :update, id: coupon_code.id, coupon_code: valid_attributes
        expect(response).to redirect_to(admin_coupon_codes_url)
      end
    end

    context "with invalid params" do
      it "assigns the coupon_code as @coupon_code" do
        put :update, id: coupon_code.id, coupon_code: invalid_attributes
        expect(assigns(:coupon_code)).to eq(coupon_code)
      end

      it "re-renders the 'edit' template" do
        put :update, id: coupon_code.id, coupon_code: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

end
