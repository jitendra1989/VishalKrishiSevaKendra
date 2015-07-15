require 'rails_helper'

RSpec.describe "admin/quotations/show", type: :view do

  let(:quotation) { FactoryGirl.create(:quotation) }

  it "renders attributes in <p>" do
    assign(:quotation, quotation)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Address/)
  end
end
