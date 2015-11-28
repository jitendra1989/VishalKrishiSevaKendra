require 'rails_helper'

RSpec.describe RequirementItem, type: :model do
	let(:requirement_item) { FactoryGirl.build(:requirement_item) }
	it { expect(requirement_item).to be_valid }
	it { expect(requirement_item).to respond_to(:requirement) }
	it { expect(requirement_item).to respond_to(:product) }
	it "has a valid product" do
		requirement_item.product = nil
		expect(requirement_item).to_not be_valid
	end
	describe 'Name assignment' do
		before { requirement_item.valid? }
		it 'assigns itself the name of the product' do
			expect(requirement_item.name).to eq(requirement_item.product.name)
		end
	end
	it "has a valid quantity" do
		requirement_item.quantity = nil
		expect(requirement_item).to_not be_valid
	end
	it "has a quantity greater than 0" do
		requirement_item.quantity = 0
		expect(requirement_item).to_not be_valid
	end
	it "cannot have fractional values" do
		requirement_item.quantity = Faker::Commerce.price
		expect(requirement_item).to_not be_valid
	end
end
