require 'rails_helper'

RSpec.describe "admin/content_pages/index", type: :view do

  let(:content_pages) { ContentPage.all }

  it "renders attributes in <p>" do
    assign(:content_pages, content_pages)
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/Slug/)
  end
end
