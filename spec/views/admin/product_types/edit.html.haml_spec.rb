require 'rails_helper'

RSpec.describe "admin/product_types/edit", type: :view do

	let(:product_type) { FactoryGirl.create(:product_type) }

	it "renders the edit product_types form" do
		assign(:product_type, product_type)
		render
		expect(response).to have_css("form")
	end
end
