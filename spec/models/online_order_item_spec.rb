require 'rails_helper'

RSpec.describe OnlineOrderItem, type: :model do
	let(:online_order_item) { FactoryGirl.build(:online_order_item) }
	it { expect(online_order_item).to be_valid }
	it { expect(online_order_item).to respond_to(:order) }
	it { expect(online_order_item).to respond_to(:product) }
	it "has a valid product" do
		online_order_item.product = nil
		expect(online_order_item).to_not be_valid
	end
	describe 'Name and price assignment' do
		before { online_order_item.valid? }
		it 'assigns itself the name of the product' do
			expect(online_order_item.name).to eq(online_order_item.product.name)
		end
	end
	it "has a valid quantity" do
		online_order_item.quantity = nil
		expect(online_order_item).to_not be_valid
	end
	it "has a quantity greater than 0" do
		online_order_item.quantity = 0
		expect(online_order_item).to_not be_valid
	end
	it "cannot have fractional values" do
		online_order_item.quantity = Faker::Commerce.price
		expect(online_order_item).to_not be_valid
	end
end
