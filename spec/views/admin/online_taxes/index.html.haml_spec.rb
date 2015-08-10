require 'rails_helper'

RSpec.describe "admin/online_taxes/index", type: :view do

  let(:online_taxes) { OnlineTax.all }

  it "renders attributes in <p>" do
    assign(:online_taxes, online_taxes)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Percentage/)
  end
end
