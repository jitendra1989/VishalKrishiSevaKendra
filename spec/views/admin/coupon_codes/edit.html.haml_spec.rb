require 'rails_helper'

RSpec.describe "admin/coupon_codes/edit", type: :view do
  let(:coupon_code) { FactoryGirl.create(:coupon_code) }

  it "renders the edit user form" do
    assign(:coupon_code, coupon_code)
    render
    assert_select "form[action=?][method=?]", admin_coupon_code_path(coupon_code), "post" do
      assert_select "input#coupon_code_code[name=?]", "coupon_code[code]"
      assert_select "input#coupon_code_percent[name=?]", "coupon_code[percent]"
    end
  end
end
