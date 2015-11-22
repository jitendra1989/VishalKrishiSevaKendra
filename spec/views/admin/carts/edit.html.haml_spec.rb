require 'rails_helper'

RSpec.describe "admin/carts/edit", type: :view do
  let(:cart) { FactoryGirl.create(:cart) }
  let(:user) { FactoryGirl.create(:user) }

  it "renders attributes in <p>" do
    assign(:cart, cart)
    assign(:order, Order.new)
    assign(:current_user, user)
    render
    expect(rendered).to match(/Product/)
    expect(rendered).to match(/Price/)
  end
end
