require 'rails_helper'

RSpec.describe "admin/requirements/show", type: :view do

  let(:requirement) { FactoryGirl.create(:requirement) }

  it "renders attributes in <p>" do
    assign(:requirement, requirement)
    render
    expect(rendered).to match(/Product/)
    expect(rendered).to match(/Qty/)
  end
end
