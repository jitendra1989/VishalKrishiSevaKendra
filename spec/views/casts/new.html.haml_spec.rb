require 'rails_helper'

RSpec.describe "casts/new", type: :view do
  before(:each) do
    assign(:cast, Cast.new(
      name: ""
    ))
  end

  it "renders new cast form" do
    render

    assert_select "form[action=?][method=?]", casts_path, "post" do

      assert_select "input[name=?]", "cast[name]"
    end
  end
end
