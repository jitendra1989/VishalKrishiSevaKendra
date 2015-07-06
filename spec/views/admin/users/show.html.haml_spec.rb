require 'rails_helper'

RSpec.describe "admin/users/show", type: :view do

  let(:user) { FactoryGirl.create(:user) }

  it "renders attributes in <p>" do
    assign(:user, user)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Contact No./)
  end
end
