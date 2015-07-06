require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
	let(:user) { FactoryGirl.create(:user) }

	describe 'GET #login' do
		it "renders login if user not logged in" do
			get :login
			expect(response).to render_template(:login)
		end

		it "renders login if user is invalid" do
			post :login, user: {username: 'sometext',  password: 'dodo' }
			expect(response).to render_template(:login)
			expect(flash.now[:danger]).to include('Invalid')
		end

		it "redirects to dashboard if user is valid" do
			post :login, user: {username: user.username,  password: user.password }
			expect(response).to redirect_to(admin_root_url)
		end

		it "redirects to dashboard if user is already logged in" do
			log_in user
			get :login
			expect(response).to redirect_to(admin_root_url)
		end

		it "redirects user to login page on logout" do
			log_in user
			delete :logout
			expect(response).to redirect_to(login_admin_users_url)
		end
	end

	describe 'Logged in actions' do
		let(:valid_attributes) { FactoryGirl.attributes_for(:basic_user) }
		let(:invalid_attributes) { FactoryGirl.attributes_for(:basic_user, username: nil) }
		before do
			log_in user
		end
		describe "GET #show" do
			it "assigns the requested user as @user" do
				get :show, id: user.id
				expect(assigns(:user)).to eq(user)
			end
		end

		describe "GET #edit" do
			it "assigns the requested user as @user" do
				get :edit, id: user.id
				expect(assigns(:user)).to eq(user)
			end
		end

		describe "PUT #update" do
				it "updates the requested user" do
					put :update, id: user.id, user: valid_attributes
					expect(assigns(:user)).to have_attributes(valid_attributes)
				end

				it "redirects to the user list" do
					put :update, id: user.id, user: valid_attributes
					expect(response).to redirect_to(admin_users_url)
				end

			context "with invalid params" do
				it "assigns the user as @user" do
					put :update, id: user.id, user: invalid_attributes
					expect(assigns(:user)).to eq(user)
				end

				it "re-renders the 'edit' template" do
					put :update, id: user.id, user: invalid_attributes
					expect(response).to render_template("edit")
				end
			end
		end

		describe "GET #index" do
			it "assigns all users as @users" do
				get :index
				expect(assigns(:users)).to eq(User.all)
			end
		end

	end


end
