require 'rails_helper'

RSpec.describe "admin/users/new", type: :view do

	let(:user) { User.new }

  let(:super_admin) { FactoryGirl.create(:super_admin) }

	it "renders the new user form" do
	  assign(:user, user)
	  assign(:current_user, super_admin)
	  render
	  assert_select "form[action=?][method=?]", admin_users_path, "post" do
	    assert_select "input#user_name[name=?]", "user[name]"
	    assert_select "input#user_username[name=?]", "user[username]"
	    assert_select "input#user_password[name=?]", "user[password]"
	    assert_select "input#user_password_confirmation[name=?]", "user[password_confirmation]"
	    assert_select "input#user_email[name=?]", "user[email]"
	    assert_select "input#user_phone[name=?]", "user[phone]"
	  end
	end

end