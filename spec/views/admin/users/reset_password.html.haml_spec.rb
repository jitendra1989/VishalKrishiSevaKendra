require 'rails_helper'

RSpec.describe "admin/users/reset_password", type: :view do

  let(:user) { FactoryGirl.create(:user) }
  let(:super_admin) { FactoryGirl.create(:super_admin ) }

  it "renders the reset_passsword user form" do
    assign(:user, user)
    assign(:current_user, super_admin)
    render
    assert_select "form[action=?][method=?]", admin_user_path(user), "post" do
      assert_select "input#user_password[name=?]", "user[password]"
      assert_select "input#user_password_confirmation[name=?]", "user[password_confirmation]"
    end
  end
end
