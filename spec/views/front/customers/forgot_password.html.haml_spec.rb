require 'rails_helper'

RSpec.describe "front/customers/forgot_password", type: :view do

  it "renders attributes in <p>" do
    render
    expect(rendered).to include('email')
  end
end
