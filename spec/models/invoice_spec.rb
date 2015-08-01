require 'rails_helper'

RSpec.describe Invoice, type: :model do
	let(:invoice) { FactoryGirl.build(:invoice) }
	it { expect(invoice).to be_valid }
	it { expect(invoice).to respond_to(:customer) }
	it { expect(invoice).to respond_to(:orders) }
	it "has a valid customer" do
		invoice.customer = nil
		expect(invoice).to_not be_valid
	end

	it "has at least one order" do
		invoice.orders = []
		expect(invoice).to_not be_valid
	end

	it 'sets the amount on invoice creation' do
		invoice.save!
		amount = 0
		invoice.orders.each do |order|
			amount += order.subtotal + order.tax_amount - order.discount_amount
		end
		expect(invoice.reload.amount).to eq(amount)
	end
end
