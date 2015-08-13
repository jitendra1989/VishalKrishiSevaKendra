require 'rails_helper'

RSpec.describe "front/offers/show", type: :view do
  let(:banner) { FactoryGirl.create(:banner) }
  let(:online_product) { FactoryGirl.create(:online_product) }
  let(:category) { FactoryGirl.create(:category) }

  before do
  	category.products << online_product
    banner.categories << category
  end

  it "renders banner" do
    view.lookup_context.prefixes << "front/application" # https://github.com/rails/rails/issues/5213
    assign(:banner, banner)
    assign(:products, Product.online.joins(:product_categories).where(product_categories: { category_id: banner.category_ids } ).distinct.page(1).per(24))
    render
    expect(rendered).to have_css('.product-box')
  end
end
