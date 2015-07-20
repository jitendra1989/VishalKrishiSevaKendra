require 'rails_helper'

RSpec.describe RolePermission, type: :model do
	let(:role_permission) { FactoryGirl.build(:role_permission) }
	it { expect(role_permission).to be_valid }
	it { expect(role_permission).to respond_to(:role) }
	it { expect(role_permission).to respond_to(:permission) }
end
