require 'rails_helper'

RSpec.describe ProductCoupon, type: :model do
	let(:product_coupon) { FactoryGirl.create(:product_coupon) }
	it { expect(product_coupon).to be_valid }
	it { expect(product_coupon).to respond_to(:product) }
	it { expect(product_coupon).to respond_to(:coupon_code) }
end
