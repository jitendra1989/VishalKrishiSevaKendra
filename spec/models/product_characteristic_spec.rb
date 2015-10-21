require 'rails_helper'

RSpec.describe ProductCharacteristic, type: :model do
	let(:product_characteristic) { FactoryGirl.create(:product_characteristic) }
	it { expect(product_characteristic).to be_valid }
	it { expect(product_characteristic).to respond_to(:product) }
	it { expect(product_characteristic).to respond_to(:characteristic) }
	it { expect(product_characteristic).to respond_to(:characteristic_image) }
	it "has a valid product" do
		product_characteristic.product = nil
		expect(product_characteristic).to_not be_valid
	end
	it "has a valid characteristic" do
		product_characteristic.characteristic = nil
		expect(product_characteristic).to_not be_valid
	end
	it "has a valid characteristic_image" do
		product_characteristic.characteristic_image = nil
		expect(product_characteristic).to_not be_valid
	end

	describe "when the characteristic is already selected" do
		subject { product_characteristic.dup }
		it { should_not be_valid }
	end
end
