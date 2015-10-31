require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
	let(:super_admin) { FactoryGirl.create(:super_admin) }
	let(:developer) { FactoryGirl.create(:user_developer) }
	let(:store_boss) { FactoryGirl.create(:user_store_boss) }
	let(:main_boss) { FactoryGirl.create(:user_main_boss) }
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
		it { should_not be_able_to(:manage, store_boss) }
		it { should_not be_able_to(:manage, main_boss) }
	end
	context 'store_boss' do
		let(:store_user) { FactoryGirl.create(:user, outlet: store_boss.outlet) }
		subject(:ability){ Ability.new(store_boss) }
		it { should be_able_to(:manage, store_boss.outlet) }
		it { should be_able_to(:manage, store_user) }
	end
	context 'main_boss' do
		subject(:ability){ Ability.new(main_boss) }
		it { should be_able_to(:manage, :all) }
		it { should_not be_able_to(:manage, developer) }
	end
	context 'developer' do
		subject(:ability){ Ability.new(developer) }
		it { should be_able_to(:manage, :all) }
	end
end
