require 'rails_helper'

RSpec.describe "admin/outlets/edit", type: :view do

  let(:outlet) { FactoryGirl.create(:outlet) }

  it "renders the edit outlet form" do
    assign(:outlet, outlet)
    render
    assert_select "form[action=?][method=?]", admin_outlet_path(outlet), "post" do
      assert_select "input#outlet_name[name=?]", "outlet[name]"
      assert_select "input#outlet_country[name=?]", "outlet[country]"
      assert_select "input#outlet_state[name=?]", "outlet[state]"
      assert_select "input#outlet_city[name=?]", "outlet[city]"
    end
  end
end
