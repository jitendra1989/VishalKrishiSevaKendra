require 'rails_helper'

RSpec.describe "admin/users/forgot_password", type: :view do

  it "renders attributes in <p>" do
    render
    expect(rendered).to include('Username')
  end
end
