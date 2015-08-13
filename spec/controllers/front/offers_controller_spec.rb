require 'rails_helper'

RSpec.describe Front::OffersController, type: :controller do
	let(:banner) { FactoryGirl.create(:banner) }
  describe "GET #show" do
    it "returns http success" do
      get :show, id: banner
      expect(assigns(:banner)).to eq(banner)
      expect(assigns(:products)).to eq(Product.online.joins(:product_categories).where(product_categories: { category_id: banner.category_ids } ).distinct.page(1).per(24))
    end
  end

end
