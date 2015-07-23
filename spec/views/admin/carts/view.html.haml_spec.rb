require 'rails_helper'

RSpec.describe "admin/carts/view", type: :view do
  let(:cart) { FactoryGirl.create(:cart) }

  it "renders attributes in <p>" do
    assign(:cart, cart)
    render
    expect(rendered).to match(/Product/)
    expect(rendered).to match(/Price/)
  end
end
