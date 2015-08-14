require 'rails_helper'

RSpec.describe Front::NotificationsController, type: :controller do
	let(:customer) { FactoryGirl.create(:customer) }
	let(:product) { FactoryGirl.create(:product) }

	before do
		customer.activate
		customer_log_in customer
	end
  describe "POST #create" do
    it "creates a new StockNotification" do
      expect {
        post :create, product_id: product.id
        }.to change(StockNotification, :count).by(1)
    end
    describe "redirect action" do
      it "redirects to the product page" do
        post :create, product_id: product.id
        expect(response).to redirect_to(front_product_url(product.id))
      end
    end
  end

end
