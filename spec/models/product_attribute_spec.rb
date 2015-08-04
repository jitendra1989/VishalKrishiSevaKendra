require 'rails_helper'

RSpec.describe ProductAttribute, type: :model do
	let(:product_attribute) { FactoryGirl.build(:product_attribute) }
	it { expect(product_attribute).to be_valid }
	it { expect(product_attribute).to respond_to(:product) }
	it { expect(product_attribute).to respond_to(:attribute_list) }
	it "has a valid product" do
		product_attribute.product = nil
		expect(product_attribute).to_not be_valid
	end
	it "has a valid attribute" do
		product_attribute.attribute_list = nil
		expect(product_attribute).to_not be_valid
	end
	it "has a valid value" do
		product_attribute.value = nil
		expect(product_attribute).to_not be_valid
	end
end
