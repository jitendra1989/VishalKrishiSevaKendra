require 'rails_helper'

RSpec.describe Banner, type: :model do
	let(:banner) { FactoryGirl.create(:banner) }
	it { expect(banner).to be_valid }
	it { expect(banner).to respond_to(:banner_categories) }
	it { expect(banner).to respond_to(:categories) }

	describe 'location' do
		let(:locations) { [:top, :column_1, :column_2, :column_3, :column_4] }

		it 'has the right index' do
			locations.each_with_index do |item, index|
				expect(described_class.locations[item]).to eq index
			end
		end
	end

	it "has a valid name" do
		banner.name = nil
		expect(banner).to_not be_valid
	end
end
