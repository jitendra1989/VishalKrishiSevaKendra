require 'rails_helper'

RSpec.describe Invoice, type: :model do
	let(:invoice) { FactoryGirl.build(:invoice) }
	it { expect(invoice).to be_valid }
	it { expect(invoice).to respond_to(:customer) }
	it "has a valid amount" do
		invoice.amount = Faker::Lorem.word
		expect(invoice).not_to be_valid
		invoice.amount = nil
		expect(invoice).to_not be_valid
	end
	it "has a valid customer" do
		invoice.amount = nil
		expect(invoice).to_not be_valid
	end
end
