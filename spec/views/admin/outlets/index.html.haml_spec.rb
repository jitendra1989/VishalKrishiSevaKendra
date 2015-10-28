require 'rails_helper'

RSpec.describe "admin/outlets/index", type: :view do

  let(:outlets) { Outlet.all.page }

  it "renders attributes in <p>" do
    assign(:outlets, outlets)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/City/)
  end
end

