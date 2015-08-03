require 'rails_helper'

RSpec.describe Banner, type: :model do
	let(:banner) { FactoryGirl.create(:banner) }
	it { expect(banner).to be_valid }
	it "has a valid name" do
		banner.name = nil
		expect(banner).to_not be_valid
	end
end
