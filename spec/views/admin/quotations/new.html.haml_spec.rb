require 'rails_helper'

RSpec.describe "admin/quotations/new", type: :view do
  let(:customer) { FactoryGirl.create(:customer) }

  it "renders new quotation form" do
  	assign(:quotation, customer.quotations.new)
  	assign(:customer, customer)
  	render
  	assert_select "form[action=?][method=?]", admin_customer_quotations_path(customer), "post" do
  		assert_select "input#quotation_discount_amount[name=?]", "quotation[discount_amount]"
  	end
  end
end
