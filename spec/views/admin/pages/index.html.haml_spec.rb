require 'rails_helper'

RSpec.describe "admin/pages/index", type: :view do
  let(:pages) { ContentPage.all }

  it "renders attributes in <p>" do
    assign(:pages, pages)
    render
    expect(rendered).to match(/Title/)
  end
end
