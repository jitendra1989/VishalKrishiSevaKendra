require 'rails_helper'

RSpec.describe "front/carts/edit", type: :view do

	it "renders attributes in <p>" do
	  assign(:cart, FactoryGirl.create(:online_cart))
	  render
	  expect(rendered).to match(/Your Shopping Cart/)
	end
end
