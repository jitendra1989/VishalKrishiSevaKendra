require 'rails_helper'

RSpec.describe "admin/roles/new", type: :view do
  let(:role) { Role.new }

  it "renders new role form" do
  	assign(:role, role)
  	render
  	assert_select "form[action=?][method=?]", admin_roles_path, "post" do
  		assert_select "input#role_name[name=?]", "role[name]"
  	end
  end
end
