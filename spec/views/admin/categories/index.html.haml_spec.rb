require 'rails_helper'

RSpec.describe "admin/categories/index", type: :view do

  let(:categories) { Category.roots }

  it "renders attributes in <p>" do
    assign(:categories, categories)
    render
    expect(rendered).to match(/Categories/)
  end
end
