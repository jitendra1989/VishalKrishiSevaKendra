require 'rails_helper'

RSpec.describe "admin/pages/edit", type: :view do
  let(:page) { ContentPage.new }

  it "renders new page form" do
  	assign(:page, page)
  	render
  	assert_select "form[action=?][method=?]", admin_pages_path, "post" do
  		assert_select "input#content_page_title[name=?]", "content_page[title]"
  	end
  end
end
