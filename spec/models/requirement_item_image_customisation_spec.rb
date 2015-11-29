require 'rails_helper'

RSpec.describe RequirementItemImageCustomisation, type: :model do
	let(:requirement_item_image_customisation) { FactoryGirl.build(:requirement_item_image_customisation) }
	it { expect(requirement_item_image_customisation).to be_valid }
	it { expect(requirement_item_image_customisation).to respond_to(:requirement_item) }
	it { expect(requirement_item_image_customisation).to respond_to(:characteristic) }
	it { expect(requirement_item_image_customisation).to respond_to(:characteristic_image) }
	it "has a valid requirement_item" do
		requirement_item_image_customisation.requirement_item = nil
		expect(requirement_item_image_customisation).not_to be_valid
	end
	it "has a valid characteristic" do
		requirement_item_image_customisation.characteristic = nil
		expect(requirement_item_image_customisation).not_to be_valid
	end
	it "has a valid characteristic_image" do
		requirement_item_image_customisation.characteristic_image = nil
		expect(requirement_item_image_customisation).not_to be_valid
	end
end
