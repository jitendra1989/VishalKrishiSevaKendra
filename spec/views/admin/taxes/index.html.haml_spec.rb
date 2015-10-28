require 'rails_helper'

RSpec.describe "admin/taxes/index", type: :view do

  let(:taxes) { Tax.all.page }

  it "renders attributes in <p>" do
    assign(:taxes, taxes)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Percentage/)
    expect(rendered).to match(/Taxes/)
  end
end
