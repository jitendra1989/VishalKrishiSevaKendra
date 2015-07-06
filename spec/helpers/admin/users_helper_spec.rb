require 'rails_helper'

RSpec.describe Admin::UsersHelper, type: :helper do
	describe "logged in check" do
		it "returns false if user not logged in" do
			expect(helper.logged_in?).to eq(false)
		end
		it "returns true if user logged in" do
			assign(:current_user, FactoryGirl.create(:user))
			expect(helper.logged_in?).to eq(true)
		end
	end
end