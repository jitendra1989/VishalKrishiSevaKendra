require 'rails_helper'

RSpec.describe UserPermission, type: :model do
	let(:user_permission) { FactoryGirl.build(:user_permission) }
	it { expect(user_permission).to be_valid }
	it { expect(user_permission).to respond_to(:user) }
	it { expect(user_permission).to respond_to(:permission) }
end
