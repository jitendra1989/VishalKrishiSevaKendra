require 'rails_helper'

RSpec.describe CartItemCustomisation, type: :model do
	let(:cart_item_customisation) { FactoryGirl.build(:cart_item_customisation) }
	it { expect(cart_item_customisation).to be_valid }
	it { expect(cart_item_customisation).to respond_to(:cart_item) }
	it { expect(cart_item_customisation).to respond_to(:specification) }
	it "has a valid cart_item" do
		cart_item_customisation.cart_item = nil
		expect(cart_item_customisation).to_not be_valid
	end
	it "has a valid specification" do
		cart_item_customisation.specification = nil
		expect(cart_item_customisation).to_not be_valid
	end
	it "has a valid value" do
		cart_item_customisation.value = nil
		expect(cart_item_customisation).to_not be_valid
	end
end
