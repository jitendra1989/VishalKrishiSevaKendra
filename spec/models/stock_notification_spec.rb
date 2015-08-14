require 'rails_helper'

RSpec.describe StockNotification, type: :model do
	let(:stock_notification) { FactoryGirl.build(:stock_notification) }

	it { expect(stock_notification).to be_valid }
	it { expect(stock_notification).to respond_to(:customer) }
	it { expect(stock_notification).to respond_to(:product) }
	it "has a valid customer" do
		stock_notification.customer = nil
		expect(stock_notification).to_not be_valid
	end
	it "has a valid product" do
		stock_notification.product = nil
		expect(stock_notification).to_not be_valid
	end
	it "cannot have duplicates" do
		stock_notification.save!
		expect(stock_notification.dup).to_not be_valid
	end
end
