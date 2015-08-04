require 'rails_helper'

RSpec.describe ProductSpecification, type: :model do
	let(:product_specification) { FactoryGirl.build(:product_specification) }
	it { expect(product_specification).to be_valid }
	it { expect(product_specification).to respond_to(:product) }
	it { expect(product_specification).to respond_to(:specification) }
	it "has a valid product" do
		product_specification.product = nil
		expect(product_specification).to_not be_valid
	end
	it "has a valid specification" do
		product_specification.specification = nil
		expect(product_specification).to_not be_valid
	end
	it "has a valid value" do
		product_specification.value = nil
		expect(product_specification).to_not be_valid
	end
end
