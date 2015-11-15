require 'rails_helper'

RSpec.describe "admin/order_item_image_customisations/edit", type: :view do

	let(:order_item_image_customisation) { FactoryGirl.create(:order_item_image_customisation) }

	it "renders the edit order_item_image_customisation form" do
		assign(:order_item_image_customisation, order_item_image_customisation)
		render
		assert_select "form[action=?][method=?]", admin_order_item_image_customisation_path(order_item_image_customisation), "post" do
			assert_select "select#order_item_image_customisation_status", OrderItemImageCustomisation.statuses
		end
	end
end
