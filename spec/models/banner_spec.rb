require 'rails_helper'

RSpec.describe Banner, type: :model do
	let(:banner) { FactoryGirl.create(:banner) }
	it { expect(banner).to be_valid }
	it { expect(banner).to respond_to(:banner_categories) }
	it { expect(banner).to respond_to(:categories) }
	it "has a valid name" do
		banner.name = nil
		expect(banner).to_not be_valid
	end
end
