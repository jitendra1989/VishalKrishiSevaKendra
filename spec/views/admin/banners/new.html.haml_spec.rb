require 'rails_helper'

RSpec.describe "admin/banners/new", type: :view do

	let(:banner) { Banner.new }

	it "renders new banner form" do
    view.lookup_context.prefixes << 'admin/application' # https://github.com/rails/rails/issues/5213
		assign(:banner, banner)
		render
		assert_select "form[action=?][method=?]", admin_banners_path, "post" do
			assert_select "input#banner_name[name=?]", "banner[name]"
			assert_select "input#banner_image[name=?]", "banner[image]"
		end
	end
end
