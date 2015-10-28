require 'rails_helper'

RSpec.describe "admin/banners/index", type: :view do

  let(:banners) { Banner.all.page }

  it "renders attributes in <p>" do
    assign(:banners, banners)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Image/)
  end
end

