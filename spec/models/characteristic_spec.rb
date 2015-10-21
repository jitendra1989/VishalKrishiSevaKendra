require 'rails_helper'

RSpec.describe Characteristic, type: :model do
  let(:characteristic) { FactoryGirl.create(:characteristic) }
  it { expect(characteristic).to respond_to(:images) }
	it { expect(characteristic).to be_valid }
	it "has a valid name" do
		characteristic.name = nil
		expect(characteristic).to_not be_valid
	end
end
