require 'rails_helper'

RSpec.describe OnlineTax, type: :model do
	let(:online_tax) { FactoryGirl.build(:online_tax) }
	it { expect(online_tax).to be_valid }
	it "has a valid name" do
		online_tax.name = nil
		expect(online_tax).to_not be_valid
	end
	it "has a valid percentage" do
		online_tax.percentage = Faker::Lorem.word
		expect(online_tax).to_not be_valid
		online_tax.percentage = nil
		expect(online_tax).to_not be_valid
	end
end
