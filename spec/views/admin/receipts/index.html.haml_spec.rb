require 'rails_helper'

RSpec.describe "admin/receipts/index", type: :view do
  let(:order) { FactoryGirl.create(:order) }

  it "renders new receipt form" do
  	assign(:order, order)
  	assign(:receipts, order.receipts)
  	render
  	expect(rendered).to match(/Receipt No/)
  	expect(rendered).to match(/Amount/)
  	expect(rendered).to match(/Payment Mode/)
  end
end
