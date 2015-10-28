require 'rails_helper'

RSpec.describe "admin/characteristics/index", type: :view do

  let(:characteristics) { Characteristic.all.page }

  it "renders characteristics in <p>" do
    assign(:characteristics, characteristics)
    render
    expect(rendered).to match(/Name/)
  end
end

