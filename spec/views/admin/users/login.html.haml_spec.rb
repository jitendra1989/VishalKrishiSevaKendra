require 'rails_helper'

RSpec.describe "admin/users/login", type: :view do

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Password/)
  end
end
