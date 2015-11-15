require 'rails_helper'

RSpec.describe "admin/workshop/index", type: :view do

  let(:order_item_customisations) { OrderItemCustomisation.all }
  let(:order_item_image_customisations) { OrderItemImageCustomisation.all }

  it "renders attributes in <p>" do
    assign(:order_item_customisations, order_item_customisations)
    assign(:order_item_image_customisations, order_item_image_customisations)
    render
    expect(rendered).to match(/Item Name/)
  end
end
