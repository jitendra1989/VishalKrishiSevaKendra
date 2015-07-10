require 'rails_helper'

RSpec.describe "admin/products/show", type: :view do
  let(:product) { FactoryGirl.create(:product) }

  it "renders attributes in <p>" do
    assign(:product, product)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(/Price/)
  end
end
