require 'rails_helper'

RSpec.describe "admin/characteristics/edit", type: :view do

	let(:characteristic) { FactoryGirl.create(:characteristic) }

	it "renders new characteristic form" do
		assign(:characteristic, characteristic)
		render
		assert_select "form[action=?][method=?]", admin_characteristic_path(characteristic), "post" do
			assert_select "input#characteristic_name[name=?]", "characteristic[name]"
		end
	end
end
