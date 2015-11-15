require 'rails_helper'

RSpec.describe "admin/order_item_customisations/edit", type: :view do

	let(:order_item_customisation) { FactoryGirl.create(:order_item_customisation) }

	it "renders the edit order_item_customisation form" do
		assign(:order_item_customisation, order_item_customisation)
		render
		assert_select "form[action=?][method=?]", admin_order_item_customisation_path(order_item_customisation), "post" do
			assert_select "select#order_item_customisation_status", OrderItemCustomisation.statuses
		end
	end
end
