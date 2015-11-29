require 'rails_helper'

RSpec.describe "admin/requirements/new", type: :view do
  let(:user) { FactoryGirl.create(:user) }

  it "renders new requirement form" do
    assign(:requirement, Requirement.new(user: user))
    assign(:current_user, user)
    render
    assert_select "form[action=?][method=?]", admin_requirements_path, "post" do
    end
  end
end
