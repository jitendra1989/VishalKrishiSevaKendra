require 'rails_helper'

RSpec.describe RolePermission, type: :model do
	let(:user) { FactoryGirl.create(:user) }
	let(:role_permission) { FactoryGirl.build(:role_permission) }
	it { expect(role_permission).to be_valid }
	it { expect(role_permission).to respond_to(:role) }
	it { expect(role_permission).to respond_to(:permission) }

	describe 'automatic update of user permissions' do
		before do
			user.roles << role_permission.role
			role_permission.save!
		end
		it 'assigns the same permission to user' do
			role_permission.role.users.each do |user|
				expect(user.permissions).to include(role_permission.permission)
			end
		end
	end
end
