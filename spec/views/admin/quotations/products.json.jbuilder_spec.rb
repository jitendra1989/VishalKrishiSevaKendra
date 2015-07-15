require 'rails_helper'

RSpec.describe "admin/quotations/products", type: :view do
  before { FactoryGirl.create_list(:product, 3) }

  it 'returns the requested products' do
    assign(:products, Product.all)
    render
    expect(rendered).to include(Product.last.name)
  end
end
