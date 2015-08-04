require 'rails_helper'

RSpec.describe "admin/banners/index", type: :view do

  let(:banners) { Banner.all }

  it "renders attributes in <p>" do
    assign(:banners, banners)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/Link/)
  end
end
