require 'rails_helper'

RSpec.describe "admin/categories/index", type: :view do

  let(:categories) { Category.all }

  it "renders attributes in <p>" do
    assign(:categories, categories)
    render
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Actions/)
  end
end
