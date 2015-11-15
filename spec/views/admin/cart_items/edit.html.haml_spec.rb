require 'rails_helper'

RSpec.describe "admin/cart_items/edit", type: :view do
  let(:cart_item) { FactoryGirl.create(:cart_item) }

  it "renders attributes in <p>" do
    assign(:cart_item, cart_item)
    assign(:cart, cart_item.cart)
    render
    expect(rendered).to include(cart_item.product.name)
  end
end
