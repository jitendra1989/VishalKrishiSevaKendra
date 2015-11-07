require 'rails_helper'

RSpec.describe CouponCode, type: :model do
  let(:coupon_code) { FactoryGirl.build(:coupon_code) }
  it { expect(coupon_code).to be_valid }
  it { expect(coupon_code).to respond_to(:products, :product_coupons) }
  it { expect(coupon_code).to respond_to(:categories, :category_coupons) }
  it "has a valid code" do
    coupon_code.code = nil
    expect(coupon_code).to_not be_valid
  end
  it "has a valid percent" do
    coupon_code.percent = Faker::Lorem.word
    expect(coupon_code).not_to be_valid
    coupon_code.percent = nil
    expect(coupon_code).not_to be_valid
  end
  it "has a valid active_from" do
    coupon_code.active_from = nil
    expect(coupon_code).to_not be_valid
  end
  it "has a valid active_to" do
    coupon_code.active_to = nil
    expect(coupon_code).to_not be_valid
  end
  it "has a valid date range" do
    coupon_code.active_from = Time.zone.tomorrow
    coupon_code.active_to = Time.zone.now
    expect(coupon_code).to_not be_valid
  end
end
