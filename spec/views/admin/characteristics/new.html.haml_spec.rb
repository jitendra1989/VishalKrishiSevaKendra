require 'rails_helper'

RSpec.describe "admin/characteristics/new", type: :view do

	let(:characteristic) { Characteristic.new }

	it "renders new characteristic form" do
		assign(:characteristic, characteristic)
		render
		assert_select "form[action=?][method=?]", admin_characteristics_path, "post" do
			assert_select "input#characteristic_name[name=?]", "characteristic[name]"
		end
	end
end
