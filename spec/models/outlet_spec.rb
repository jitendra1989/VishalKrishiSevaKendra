require 'rails_helper'

RSpec.describe Outlet, type: :model do
	let(:outlet) { FactoryGirl.build(:outlet) }
	let(:superadmin) { FactoryGirl.create(:super_admin) }
	it { expect(outlet).to be_valid }
	it { expect(outlet).to respond_to(:users) }
	it { expect(outlet).to respond_to(:stocks) }
	it { expect(outlet).to respond_to(:carts) }
	it "has a valid name" do
		outlet.name = nil
		expect(outlet).to_not be_valid
	end
	it "has a valid city" do
		outlet.city = nil
		expect(outlet).to_not be_valid
	end
	it "has a valid state" do
		outlet.state = nil
		expect(outlet).to_not be_valid
	end
	it "has a valid country" do
		outlet.country = nil
		expect(outlet).to_not be_valid
	end
end
