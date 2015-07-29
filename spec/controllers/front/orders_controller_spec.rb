require 'rails_helper'

RSpec.describe Front::OrdersController, type: :controller do
  let(:customer) { FactoryGirl.create(:customer) }

  describe "logged in customer" do
    before do
      customer_log_in customer
    end
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

end
