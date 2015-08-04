require 'rails_helper'

RSpec.describe Attribute, type: :model do
	let(:attribute) { FactoryGirl.create(:attribute) }
	it { expect(attribute).to be_valid }
	it { expect(attribute).to respond_to(:product_attributes) }
	it "has a valid name" do
		attribute.name = nil
		expect(attribute).to_not be_valid
	end
	it "has only allowed units" do
		attribute.units = 'randomtext'
		expect(attribute).to_not be_valid
	end
end
