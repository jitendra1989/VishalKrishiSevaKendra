require 'rails_helper'

RSpec.describe Permission, type: :model do
	let(:permission) { FactoryGirl.build(:permission) }
	it { expect(permission).to be_valid }
	it "has a valid name" do
		permission.name = nil
		expect(permission).to_not be_valid
	end
	it "has a valid subject_class" do
		permission.subject_class = nil
		expect(permission).to_not be_valid
	end
	it "has a valid action" do
		permission.action = nil
		expect(permission).to_not be_valid
	end
	it "has a valid description" do
		permission.description = nil
		expect(permission).to_not be_valid
	end
end
