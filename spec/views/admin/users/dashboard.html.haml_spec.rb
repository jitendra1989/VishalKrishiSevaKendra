require 'rails_helper'

RSpec.describe "admin/users/dashboard", type: :view do

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Dashboard/)
  end
end
