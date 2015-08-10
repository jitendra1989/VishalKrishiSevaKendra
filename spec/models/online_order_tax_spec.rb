require 'rails_helper'

RSpec.describe OnlineOrderTax, type: :model do
	let(:online_order_tax) { FactoryGirl.build(:online_order_tax) }
	it { expect(online_order_tax).to be_valid }
	it { expect(online_order_tax).to respond_to(:order) }
	it "has a valid name" do
		online_order_tax.name = nil
		expect(online_order_tax).to_not be_valid
	end
	it "has a valid amount" do
	  online_order_tax.amount = Faker::Lorem.word
	  expect(online_order_tax).not_to be_valid
	  online_order_tax.amount = nil
	  expect(online_order_tax).not_to be_valid
	end
end
