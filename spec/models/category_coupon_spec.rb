require 'rails_helper'

RSpec.describe CategoryCoupon, type: :model do
	let(:category_coupon) { FactoryGirl.create(:category_coupon) }
	it { expect(category_coupon).to be_valid }
	it { expect(category_coupon).to respond_to(:category) }
	it { expect(category_coupon).to respond_to(:coupon_code) }
end
