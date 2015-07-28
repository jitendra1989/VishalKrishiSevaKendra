require 'rails_helper'

RSpec.describe "front/categories/show", type: :view do
  let(:category) { FactoryGirl.create(:category) }

  before do
  	category.products << FactoryGirl.create_list(:product, 2)
  end

  it "renders category" do
  	view.lookup_context.prefixes << "front/application" # https://github.com/rails/rails/issues/5213
  	assign(:category, category)
  	render
  	expect(rendered).to have_css('.product-box')
  end
end
