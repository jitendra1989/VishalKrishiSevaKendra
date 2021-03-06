require 'rails_helper'

RSpec.describe Role, type: :model do
	let(:role) { FactoryGirl.build(:role) }
	it { expect(role).to be_valid }
	it { expect(role).to respond_to(:permissions) }
	it { expect(role).to respond_to(:role_permissions) }
	it { expect(role).to respond_to(:user_roles) }
	it { expect(role).to respond_to(:users) }
	it "has a valid name" do
		role.name = nil
		expect(role).not_to be_valid
	end
	describe "when name is already taken" do
		let(:role_with_same_name) { FactoryGirl.build(:role, name: role.name) }
		before do
			role.save
		end
		it { expect(role_with_same_name).not_to be_valid }
	end
end
