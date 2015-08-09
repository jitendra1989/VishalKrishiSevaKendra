require 'rails_helper'

RSpec.describe OrderTax, type: :model do
	let(:order_tax) { FactoryGirl.build(:order_tax) }
	it { expect(order_tax).to be_valid }
	it { expect(order_tax).to respond_to(:order) }
	it "has a valid name" do
		order_tax.name = nil
		expect(order_tax).to_not be_valid
	end
	it "has a valid amount" do
	  order_tax.amount = Faker::Lorem.word
	  expect(order_tax).not_to be_valid
	  order_tax.amount = nil
	  expect(order_tax).not_to be_valid
	end
end
