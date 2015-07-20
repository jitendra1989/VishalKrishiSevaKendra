require 'rails_helper'

RSpec.describe "admin/product_types/index", type: :view do
  let(:product_types) { ProductType.all }
  before { FactoryGirl.create_list(:product_type, 2) }

  it "renders attributes in <p>" do
    assign(:product_types, product_types)
    render
    expect(response).to have_css(".product_type")
   end
end
