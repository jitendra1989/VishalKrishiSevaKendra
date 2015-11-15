require 'rails_helper'

RSpec.describe OrderItemImageCustomisation, type: :model do
	let(:order_item_image_customisation) { FactoryGirl.build(:order_item_image_customisation) }
	it { expect(order_item_image_customisation).to be_valid }
	it { expect(order_item_image_customisation).to respond_to(:order_item) }
	it { expect(order_item_image_customisation).to respond_to(:characteristic) }
	it { expect(order_item_image_customisation).to respond_to(:characteristic_image) }
	it "has a valid order_item" do
		order_item_image_customisation.order_item = nil
		expect(order_item_image_customisation).not_to be_valid
	end
	it "has a valid characteristic" do
		order_item_image_customisation.characteristic = nil
		expect(order_item_image_customisation).not_to be_valid
	end
	it "has a valid characteristic_image" do
		order_item_image_customisation.characteristic_image = nil
		expect(order_item_image_customisation).not_to be_valid
	end
end
