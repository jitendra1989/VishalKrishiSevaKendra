require 'rails_helper'

RSpec.describe "admin/requirements/edit", type: :view do
  let(:user) { FactoryGirl.create(:user) }
  let(:requirement) { FactoryGirl.create(:requirement, user: user) }

  it "renders new requirement form" do
    assign(:requirement, requirement)
    assign(:current_user, user)
    render
    assert_select "form[action=?][method=?]", admin_requirement_path(requirement), "post" do
    end
  end
end
