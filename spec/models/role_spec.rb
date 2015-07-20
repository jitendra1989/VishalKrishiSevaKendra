require 'rails_helper'

RSpec.describe Role, type: :model do
	let(:role) { FactoryGirl.build(:role) }
	it { expect(role).to be_valid }
	it { expect(role).to respond_to(:permissions) }
	it { expect(role).to respond_to(:role_permissions) }
	it "has a valid name" do
		role.name = nil
		expect(role).not_to be_valid
	end
end
