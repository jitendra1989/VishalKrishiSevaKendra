require 'rails_helper'

RSpec.describe "admin/outlets/new", type: :view do

	let(:outlet) { Outlet.new }

	it "renders new outlet form" do
		assign(:outlet, outlet)
		render
		assert_select "form[action=?][method=?]", admin_outlets_path, "post" do
			assert_select "input#outlet_name[name=?]", "outlet[name]"
			assert_select "input#outlet_country[name=?]", "outlet[country]"
			assert_select "input#outlet_state[name=?]", "outlet[state]"
			assert_select "input#outlet_city[name=?]", "outlet[city]"
		end
	end
end
