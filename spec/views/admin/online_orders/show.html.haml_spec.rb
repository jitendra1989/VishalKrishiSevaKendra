require 'rails_helper'

RSpec.describe "admin/online_orders/show", type: :view do
  let(:online_order) { FactoryGirl.create(OnlineOrder) }

  	it "renders attributes in <p>" do
  		assign(:online_order, online_order)
  		render
  		expect(rendered).to match(/Order No/)
  	end
end
