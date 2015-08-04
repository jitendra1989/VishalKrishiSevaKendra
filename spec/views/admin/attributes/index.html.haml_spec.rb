require 'rails_helper'

RSpec.describe "admin/attributes/index", type: :view do

  let(:attributes) { Attribute.all }

  it "renders attributes in <p>" do
    assign(:attributes, attributes)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Type/)
  end
end

