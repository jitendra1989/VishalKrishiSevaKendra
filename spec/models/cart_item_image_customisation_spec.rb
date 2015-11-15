require 'rails_helper'

RSpec.describe CartItemImageCustomisation, type: :model do
	let(:cart_item_image_customisation) { FactoryGirl.build(:cart_item_image_customisation) }
	it { expect(cart_item_image_customisation).to be_valid }
	it { expect(cart_item_image_customisation).to respond_to(:cart_item) }
	it { expect(cart_item_image_customisation).to respond_to(:characteristic) }
	it { expect(cart_item_image_customisation).to respond_to(:characteristic_image) }
	it "has a valid cart_item" do
		cart_item_image_customisation.cart_item = nil
		expect(cart_item_image_customisation).not_to be_valid
	end
	it "has a valid characteristic" do
		cart_item_image_customisation.characteristic = nil
		expect(cart_item_image_customisation).not_to be_valid
	end
	it "has a valid characteristic_image" do
		cart_item_image_customisation.characteristic_image = nil
		expect(cart_item_image_customisation).not_to be_valid
	end
end
