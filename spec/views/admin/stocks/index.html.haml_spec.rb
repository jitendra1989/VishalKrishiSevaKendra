require 'rails_helper'

RSpec.describe "admin/stocks/index", type: :view do

  let(:product) { FactoryGirl.create(:product) }
  let(:stocks) { FactoryGirl.create_list(:stock, 3, product: product) }

  it "renders attributes in <p>" do
    assign(:stocks, stocks)
    assign(:product, product)
    render
    expect(rendered).to match(/Product/)
    expect(rendered).to match(/Quantity/)
  end
end
