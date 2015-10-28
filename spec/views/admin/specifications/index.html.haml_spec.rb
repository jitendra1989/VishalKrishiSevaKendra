require 'rails_helper'

RSpec.describe "admin/specifications/index", type: :view do

  let(:specifications) { Specification.all.page }

  it "renders specifications in <p>" do
    assign(:specifications, specifications)
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Type/)
  end
end

