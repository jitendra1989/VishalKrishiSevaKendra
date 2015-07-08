require 'rails_helper'

RSpec.describe "admin/users/edit", type: :view do

  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:user, role: User::ROLES.first ) }

  it "renders the edit user form" do
    assign(:user, user)
    assign(:current_user, admin)
    render
    assert_select "form[action=?][method=?]", admin_user_path(user), "post" do
      assert_select "input#user_name[name=?]", "user[name]"
      assert_select "input#user_username[name=?]", "user[username]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_phone[name=?]", "user[phone]"
    end
  end
end
