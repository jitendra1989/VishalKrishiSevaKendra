require 'rails_helper'

RSpec.describe "admin/banners/edit", type: :view do

  let(:banner) { FactoryGirl.create(:banner) }

  it "renders the edit banner form" do
    assign(:banner, banner)
    render
    assert_select "form[action=?][method=?]", admin_banner_path(banner), "post" do
      assert_select "input#banner_name[name=?]", "banner[name]"
      assert_select "input#banner_image[name=?]", "banner[image]"
      assert_select "input#banner_url[name=?]", "banner[url]"
    end
  end
end
