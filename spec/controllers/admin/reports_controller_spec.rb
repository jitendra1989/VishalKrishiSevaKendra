require 'rails_helper'

RSpec.describe Admin::ReportsController, type: :controller do
	let(:user) { FactoryGirl.create(:super_admin) }
	before do
	  log_in user
	end

  describe "GET #stock" do
    it "returns http success" do
      get :stock
      expect(response.status).to eq(200)
    end
  end

  describe "GET #workshop" do
    it "returns http success" do
      get :workshop
      expect(response.status).to eq(200)
    end
  end

end
