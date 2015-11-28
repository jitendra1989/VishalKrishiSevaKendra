require 'rails_helper'

RSpec.describe RequirementItemCustomisation, type: :model do
	let(:requirement_item_customisation) { FactoryGirl.build(:requirement_item_customisation) }
	it { expect(requirement_item_customisation).to be_valid }
	it { expect(requirement_item_customisation).to respond_to(:requirement_item) }
	it { expect(requirement_item_customisation).to respond_to(:specification) }
	it "has a valid requirement_item" do
		requirement_item_customisation.requirement_item = nil
		expect(requirement_item_customisation).to_not be_valid
	end
	it "has a valid specification" do
		requirement_item_customisation.specification = nil
		expect(requirement_item_customisation).to_not be_valid
	end
	it "has a valid value" do
		requirement_item_customisation.value = nil
		expect(requirement_item_customisation).to_not be_valid
	end
end
