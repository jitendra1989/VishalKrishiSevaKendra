require 'rails_helper'

RSpec.describe "admin/users/index", type: :view do

  let(:users) { User.all }

  it "renders attributes in <p>" do
    assign(:users, users)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/Contact/)
  end
end
