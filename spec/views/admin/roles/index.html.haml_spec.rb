require 'rails_helper'

RSpec.describe "admin/roles/index", type: :view do
  let(:roles) { Role.all }

  it "renders attributes in <p>" do
    assign(:roles, roles)
    render
    expect(rendered).to match(/Name/)
  end
end
