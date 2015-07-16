require 'rails_helper'

RSpec.describe ProductType, type: :model do
	let(:product_type) { FactoryGirl.build(:product_type) }
	it { expect(product_type).to be_valid }
	it { expect(product_type).to respond_to(:product_type_taxes) }
	it { expect(product_type).to respond_to(:taxes) }
	it { expect(product_type).to respond_to(:products) }
	it "has a valid product_type name" do
		product_type.name = nil
		expect(product_type).to_not be_valid
	end
end
