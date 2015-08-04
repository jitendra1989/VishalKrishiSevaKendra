require 'rails_helper'

RSpec.describe "admin/content_pages/edit", type: :view do

  let(:content_page) { FactoryGirl.create(:content_page) }

  it "renders the edit content_page form" do
    assign(:content_page, content_page)
    render
    assert_select "form[action=?][method=?]", admin_content_page_path(content_page), "post" do
      assert_select "input#content_page_title[name=?]", "content_page[title]"
      assert_select "textarea#content_page_content[name=?]", "content_page[content]"
      assert_select "input#content_page_slug[name=?]", "content_page[slug]"
    end
  end
end
