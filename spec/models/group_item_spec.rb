require 'rails_helper'

RSpec.describe GroupItem, type: :model do
	let(:group_item) { FactoryGirl.build(:group_item) }
	it { expect(group_item).to be_valid }
	it { expect(group_item).to respond_to(:product) }
	it { expect(group_item).to respond_to(:related_product) }
	it "has a valid related_product" do
		group_item.related_product = nil
		expect(group_item).not_to be_valid
	end
	it "cannot have self as related_product" do
		group_item.product = group_item.related_product
		expect(group_item).not_to be_valid
	end
	it "has a valid quantity" do
		group_item.quantity = nil
		expect(group_item).to_not be_valid
	end
	it "has a quantity greater than 0" do
		group_item.quantity = 0
		expect(group_item).to_not be_valid
	end
	it "cannot have fractional values" do
		group_item.quantity = Faker::Commerce.price
		expect(group_item).to_not be_valid
	end
end
