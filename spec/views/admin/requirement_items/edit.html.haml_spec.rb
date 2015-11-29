require 'rails_helper'

RSpec.describe "admin/requirement_items/edit", type: :view do
  let(:requirement_item) { FactoryGirl.create(:requirement_item) }

  it "renders attributes in <p>" do
    assign(:requirement_item, requirement_item)
    assign(:requirement, requirement_item.requirement)
    render
    expect(rendered).to include(requirement_item.product.name)
  end
end
