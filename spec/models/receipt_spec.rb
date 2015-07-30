require 'rails_helper'

RSpec.describe Receipt, type: :model do
	let(:receipt) { FactoryGirl.build(:receipt) }
	it { expect(receipt).to be_valid }
	it { expect(receipt).to respond_to(:user) }
	it { expect(receipt).to respond_to(:order) }
	it "has a valid amount" do
		receipt.amount = Faker::Lorem.word
		expect(receipt).not_to be_valid
		receipt.amount = nil
		expect(receipt).to_not be_valid
	end
	it "has a valid user" do
		receipt.user = nil
		expect(receipt).to_not be_valid
	end
	it "has a valid order" do
		receipt.order = nil
		expect(receipt).to_not be_valid
	end
end
