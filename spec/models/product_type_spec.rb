require 'rails_helper'

RSpec.describe ProductType, type: :model do
	let(:product_type) { FactoryGirl.build(:product_type) }
	it { expect(product_type).to be_valid }
	it "has a valid product_type name" do
		product_type.name = nil
		expect(product_type).to_not be_valid
	end
end
