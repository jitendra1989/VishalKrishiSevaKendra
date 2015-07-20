require 'rails_helper'

RSpec.describe UserRole, type: :model do
	let(:user_role) { FactoryGirl.build(:user_role) }
	it { expect(user_role).to be_valid }
	it { expect(user_role).to respond_to(:user) }
	it { expect(user_role).to respond_to(:role) }
end
