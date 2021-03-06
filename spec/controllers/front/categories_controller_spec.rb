require 'rails_helper'

RSpec.describe Front::CategoriesController, type: :controller do
	let(:category) { FactoryGirl.create(:category) }
  describe "GET #show" do
    it "returns http success" do
      get :show, id: category
      expect(assigns(:category)).to eq(category)
      expect(assigns(:products)).to eq(Product.online.joins(:product_categories).where(product_categories: { category_id: category.descendant_ids << category.id } ).distinct.page(1).per(24))
    end
  end

end
