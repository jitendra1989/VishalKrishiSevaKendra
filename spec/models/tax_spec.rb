require 'rails_helper'

RSpec.describe Tax, type: :model do
	let(:tax) { FactoryGirl.build(:tax) }
	it { expect(tax).to be_valid }
	it "has a valid name" do
		tax.name = nil
		expect(tax).to_not be_valid
	end
	it "has a valid percentage" do
		tax.percentage = Faker::Lorem.word
		expect(tax).to_not be_valid
		tax.percentage = nil
		expect(tax).to_not be_valid
	end
end
