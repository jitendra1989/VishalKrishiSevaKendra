require 'rails_helper'

RSpec.describe CouponCode, type: :model do
  let(:coupon_code) { FactoryGirl.build(:coupon_code) }
  it { expect(coupon_code).to be_valid }
  it "has a valid code" do
    coupon_code.code = nil
    expect(coupon_code).to_not be_valid
  end
  it "has a valid percent" do
    coupon_code.percent = nil
    expect(coupon_code).to_not be_valid
  end
  it "has a valid active_from" do
    coupon_code.active_from = nil
    expect(coupon_code).to_not be_valid
  end
  it "has a valid active_to" do
    coupon_code.active_to = nil
    expect(coupon_code).to_not be_valid
  end
end
