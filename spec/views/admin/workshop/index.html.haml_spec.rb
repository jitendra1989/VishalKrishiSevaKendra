require 'rails_helper'

RSpec.describe "admin/workshop/index", type: :view do

  let(:order_items) { OrderItem.all }

  it "renders attributes in <p>" do
    assign(:order_items, order_items)
    render
    expect(rendered).to match(/Item Name/)
  end
end
