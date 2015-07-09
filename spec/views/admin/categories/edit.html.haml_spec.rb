require 'rails_helper'

RSpec.describe "admin/categories/edit", type: :view do

  let(:category) { FactoryGirl.create(:category) }

  it "renders the edit category form" do
    assign(:category, category)
    render
    assert_select "form[action=?][method=?]", admin_category_path(category), "post" do
      assert_select "input#category_name[name=?]", "category[name]"
    end
  end
end
