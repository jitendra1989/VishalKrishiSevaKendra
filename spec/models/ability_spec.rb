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
end
