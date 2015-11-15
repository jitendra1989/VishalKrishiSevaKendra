require 'rails_helper'

RSpec.describe "admin/order_item_customisations/index", type: :view do

  let(:order_item_customisations) { OrderItemCustomisation.all }

  it "renders attributes in <p>" do
    assign(:order_item_customisations, order_item_customisations)
    render
    expect(rendered).to match(/Item Name/)
  end
end
