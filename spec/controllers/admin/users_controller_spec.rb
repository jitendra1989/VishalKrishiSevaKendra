require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
	let(:user) { FactoryGirl.create(:super_admin) }

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

		describe "forgot-password" do
			it "renders forgot_password" do
				get :forgot_password
				expect(response).to render_template(:forgot_password)
			end
			it "redirects to the login page with a flash notice" do
				post :forgot_password, user: { username: user.username }
				expect(response).to redirect_to(login_admin_users_url)
				expect(flash[:info]).to eq('We have sent an email with password reset instructions.')
			end
		end

		describe "on accessing link from email" do
			before do
				user.password_reset_token = 'XXXXXXXXXXXXXXXXXXXX'
				user.password_reset_sent_at = 1.hour.ago
				user.save!
			end
			describe "GET recover-password" do
				it "renders recover_password if user not logged in" do
					get :recover_password, { token: user.password_reset_token }
					expect(response).to render_template(:recover_password)
				end
			end

			describe "POST recover-password" do
				it "renders recover_password if passwords don't match" do
					password = Faker::Internet.password(6, 25)
					post :recover_password, { user: { password: password, password_confirmation: "misMatch"}, token: user.password_reset_token  }
					expect(response).to render_template(:recover_password)
				end

				describe "when link has expired" do
					before do
						user.password_reset_sent_at = 3.hours.ago
						user.save!
					end
					it "renders forgot-password if link has expired" do
						password = Faker::Internet.password(6, 25)
						post :recover_password, { user: { password: password, password_confirmation: password}, token: user.password_reset_token  }
						expect(response).to redirect_to( forgot_password_admin_users_url)
					end
				end

			it "renders login on successful password update" do
				password = Faker::Internet.password(6, 25)
				post :recover_password, { user: { password: password, password_confirmation: password}, token: user.password_reset_token  }
				expect(response).to redirect_to(login_admin_users_url)
			end
			end
		end
	end

	describe 'Logged in actions for super admin' do
		let(:valid_attributes) { FactoryGirl.attributes_for(:user) }
		let(:all_attributes) { FactoryGirl.attributes_for(:user) }
		let(:invalid_attributes) { FactoryGirl.attributes_for(:user, username: nil) }
		before do
			log_in user
		end
		describe "GET #dashboard" do
			it "renders the dashboard page" do
				get :dashboard
				expect(response).to render_template(:dashboard)
			end
		end
		describe "GET #show" do
			it "assigns the requested user as @user" do
				get :show, id: user.id
				expect(assigns(:user)).to eq(user)
			end
		end

		describe "GET #reset_password" do
			it "assigns the requested user as @user" do
				get :reset_password, id: user.id
				expect(assigns(:user)).to eq(user)
			end
		end
		describe "GET #new" do
			it "assigns a new user as @user" do
				get :new
				expect(assigns(:user)).to be_a_new(User)
			end
		end
		describe "POST #create" do
			context "with valid params" do
				it "creates a new User" do
					expect {
						post :create, user: all_attributes
					}.to change(User, :count).by(1)
				end

				it "assigns a newly created user as @user" do
					post :create, user: all_attributes
					expect(assigns(:user)).to be_a(User)
					expect(assigns(:user)).to be_persisted
				end

				it "redirects to the created user" do
					post :create, user: all_attributes
					expect(response).to redirect_to(admin_users_url)
				end
			end

			context "with invalid params" do
				it "assigns a newly created but unsaved user as @user" do
					post :create, user: invalid_attributes
					expect(assigns(:user)).to be_a_new(User)
				end

				it "re-renders the 'new' template" do
					post :create, user: invalid_attributes
					expect(response).to render_template("new")
				end
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

				describe "with roles" do
					let(:role) { FactoryGirl.create(:role) }
					it "add the selected roles to the user" do
						expect {
							post :update, id: user.id, user: valid_attributes.merge(role_ids: [role.id])
							}.to change(UserRole, :count).by(1)
					end
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
			it "assigns all admin users as @users" do
				get :index
				expect(assigns(:users)).to eq(User.all.page)
			end
		end

		describe "DELETE #destroy" do
			it "destroys the requested user" do
				expect {
					delete :destroy, id: user.id
				}.to change(User, :count).by(-1)
			end

			it "redirects to the users list" do
				delete :destroy, id: user.id
				expect(response).to redirect_to(admin_users_url)
			end
		end
	end
end
