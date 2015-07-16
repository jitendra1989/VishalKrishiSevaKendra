require 'rails_helper'

RSpec.describe "admin/taxes/index", type: :view do

  let(:taxes) { Outlet.all }

  it "renders attributes in <p>" do
    assign(:taxes, taxes)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Percentage/)
  end
end
