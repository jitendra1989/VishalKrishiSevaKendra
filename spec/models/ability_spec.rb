require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
	let(:super_admin) { FactoryGirl.create(:super_admin) }
	let(:developer) { FactoryGirl.create(:user_developer) }
	context "non logged in user" do
		let(:guest) { User.new }
		subject(:ability){ Ability.new(guest) }
		it{ should be_able_to(:forgot_password, User) }
		it{ should be_able_to(:recover_password, User) }
		it{ should be_able_to(:login, User) }
		it{ should be_able_to(:logout, User) }
		it{ should be_able_to(:dashboard, User) }
	end
	context 'super_admin' do
		subject(:ability){ Ability.new(super_admin) }
		it { should be_able_to(:manage, :all) }
		it { should_not be_able_to(:manage, developer) }
	end
	context 'developer' do
		subject(:ability){ Ability.new(developer) }
		it { should be_able_to(:manage, :all) }
	end
end
