require 'rails_helper'

RSpec.describe "admin/coupon_codes/new", type: :view do
  let(:coupon_code) { CouponCode.new }

  	it "renders the new coupon_code form" do
  		assign(:coupon_code, coupon_code)
  		render
  		assert_select "form[action=?][method=?]", admin_coupon_codes_path, "post" do
  			assert_select "input#coupon_code_code[name=?]", "coupon_code[code]"
  			assert_select "input#coupon_code_percent[name=?]", "coupon_code[percent]"
  		end
  	end
end
