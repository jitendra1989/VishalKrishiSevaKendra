require 'rails_helper'

RSpec.describe Admin::PermissionsController, type: :controller do
	let(:user) { FactoryGirl.create(:super_admin) }
	let(:permission) { FactoryGirl.create(:permission) }
	before do
	  log_in user
	end

  describe "GET #index" do
    it "assigns all permissions as @permissions" do
      get :index
      expect(assigns(:permissions)).to eq(Permission.all)
    end
  end

end
