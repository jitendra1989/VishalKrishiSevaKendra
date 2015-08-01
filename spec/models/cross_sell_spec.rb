require 'rails_helper'

RSpec.describe CrossSell, type: :model do
	let(:cross_sell) { FactoryGirl.build(:cross_sell) }
	it { expect(cross_sell).to be_valid }
	it { expect(cross_sell).to respond_to(:product) }
	it { expect(cross_sell).to respond_to(:related_product) }
end
