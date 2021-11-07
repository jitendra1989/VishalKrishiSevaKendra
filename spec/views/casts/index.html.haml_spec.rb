require 'rails_helper'

RSpec.describe "casts/index", type: :view do
  before(:each) do
    assign(:casts, [
      Cast.create!(
        name: ""
      ),
      Cast.create!(
        name: ""
      )
    ])
  end

  it "renders a list of casts" do
    render
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
