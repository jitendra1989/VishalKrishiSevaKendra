require 'rails_helper'

RSpec.describe "admin/orders/show", type: :view do
  let(:order) { FactoryGirl.create(Order) }

  	it "renders attributes in <p>" do
  		assign(:order, order)
  		render
  		expect(rendered).to match(/Order No/)
  	end
end
