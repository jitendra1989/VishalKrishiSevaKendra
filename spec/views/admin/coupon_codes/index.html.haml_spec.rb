require 'rails_helper'

RSpec.describe "admin/coupon_codes/index", type: :view do
  let(:coupon_codes) { CouponCode.all }
  it "renders attributes in <p>" do
    assign(:coupon_codes, coupon_codes)
    render
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Percent/)
  end
end






