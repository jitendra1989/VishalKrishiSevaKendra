require 'rails_helper'

RSpec.describe Attribute, type: :model do
	let(:attribute) { FactoryGirl.create(:attribute) }
	it { expect(attribute).to be_valid }
	it "has a valid name" do
		attribute.name = nil
		expect(attribute).to_not be_valid
	end
end
