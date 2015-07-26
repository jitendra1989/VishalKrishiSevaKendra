require 'rails_helper'

RSpec.describe OrderItem, type: :model do
	let(:order_item) { FactoryGirl.build(:order_item) }
	it { expect(order_item).to be_valid }
	it { expect(order_item).to respond_to(:order) }
	it { expect(order_item).to respond_to(:product) }
	it "has a valid product" do
		order_item.product = nil
		expect(order_item).to_not be_valid
	end
	describe 'Name and price assignment' do
		before { order_item.valid? }
		it 'assigns itself the name of the product' do
			expect(order_item.name).to eq(order_item.product.name)
		end
	end
	it "has a valid quantity" do
		order_item.quantity = nil
		expect(order_item).to_not be_valid
	end
	it "has a quantity greater than 0" do
		order_item.quantity = 0
		expect(order_item).to_not be_valid
	end
	it "cannot have fractional values" do
		order_item.quantity = Faker::Commerce.price
		expect(order_item).to_not be_valid
	end
end
