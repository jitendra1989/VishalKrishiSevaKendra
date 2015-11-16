require 'rails_helper'

RSpec.describe Admin::WorkshopController, type: :controller do
	let(:user) { FactoryGirl.create(:super_admin) }

	describe "without login" do
		it "redirects to the login page" do
			get :index
			expect(response).to redirect_to(login_admin_users_url)
		end
	end

	describe " logged in user" do
		before do
			log_in user
		end
		describe "GET #index" do
			it "assigns all order_item_customisations as @order_item_customisations" do
				get :index
				expect(assigns(:order_items)).to eq(OrderItem.includes(:customisations, :image_customisations).where('customisations_count != 0 OR image_customisations_count != 0').order('order_id DESC'))
			end
		end
	end

end
