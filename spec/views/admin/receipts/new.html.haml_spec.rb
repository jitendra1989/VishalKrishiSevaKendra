require 'rails_helper'

RSpec.describe "admin/receipts/new", type: :view do
  let(:order) { FactoryGirl.create(:order) }

  it "renders new receipt form" do
  	assign(:order, order)
  	assign(:receipt, order.receipts.build)
  	render
  	assert_select "form[action=?][method=?]", admin_order_receipts_path(order), "post" do
  		assert_select "input#receipt_amount[name=?]", "receipt[amount]"
  	end
  end
end
