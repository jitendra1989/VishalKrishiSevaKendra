require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
	let(:user) { FactoryGirl.build(:user) }
	let(:super_admin) { FactoryGirl.create(:super_admin) }
	let(:admin) { FactoryGirl.create(:admin) }
	let(:sales_executive) { FactoryGirl.create(:sales_executive) }
	let(:production_manager) { FactoryGirl.create(:production_manager) }
	context "non logged in user" do
		let(:guest) { User.new }
		subject(:ability){ Ability.new(guest) }
		it{ should be_able_to(:login, User) }
	end
	context "when is a super admin" do
		subject(:ability){ Ability.new(super_admin) }
		it{ should be_able_to(:manage, :all) }
	end
	context "when is an admin" do
		subject(:ability){ Ability.new(admin) }
		it{ should_not be_able_to(:manage, Outlet) }
		it{ should_not be_able_to(:manage, Product) }
		it{ should_not be_able_to(:manage, Category) }
		it{ should_not be_able_to(:manage, User.new(role: "super_admin")) }
		it{ should be_able_to(:manage, User.new(outlet: admin.outlet)) }
		it{ should be_able_to(:dashboard, User) }
	end
	context "when is sales_executive" do
		subject(:ability){ Ability.new(sales_executive) }
		it{ should_not be_able_to(:manage, Outlet) }
		it{ should_not be_able_to(:manage, Product) }
		it{ should_not be_able_to(:manage, Category) }
		it{ should_not be_able_to(:manage, User.new) }
		it{ should_not be_able_to(:manage, User.new(outlet: sales_executive.outlet)) }
		it{ should_not be_able_to(:manage, sales_executive) }
		it{ should be_able_to(:dashboard, User) }
	end
	context "when is an production manager" do
		subject(:ability){ Ability.new(production_manager) }
		it{ should_not be_able_to(:manage, Outlet) }
		it{ should_not be_able_to(:manage, Product) }
		it{ should_not be_able_to(:manage, Category) }
		it{ should_not be_able_to(:manage, User.new) }
		it{ should_not be_able_to(:manage, User.new(outlet: production_manager.outlet)) }
		it{ should_not be_able_to(:manage, production_manager) }
		it{ should be_able_to(:dashboard, User) }
		it{ should be_able_to(:logout, User) }
	end
end
