require 'rails_helper'

RSpec.describe Specification, type: :model do
	let(:specification) { FactoryGirl.create(:specification) }
	it { expect(specification).to be_valid }
	it { expect(specification).to respond_to(:product_specifications) }
	it "has a valid name" do
		specification.name = nil
		expect(specification).to_not be_valid
	end
	it "has only allowed units" do
		specification.units = 'randomtext'
		expect(specification).to_not be_valid
	end
end
