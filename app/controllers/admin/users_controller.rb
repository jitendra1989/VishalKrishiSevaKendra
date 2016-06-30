class Admin::UsersController < Admin::ApplicationController
  skip_before_action :require_login, only: [:login, :forgot_password, :recover_password]
  load_and_authorize_resource

  def index
    @users = User.includes(:outlet).all.page(params[:page])
  end

  def login
    if request.post?
      user = User.find_by(username: params[:user][:username])
      if user && user.authenticate(params[:user][:password])
        log_in user
      else
        flash.now[:danger] = "Invalid username or password!"
      end
    end
    redirect_to admin_root_url if logged_in?
  end

  def logout
    log_out
    redirect_to login_admin_users_url
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def dashboard
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url, flash: { success: 'User was successfully created.' }
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_url, flash: { success: 'User was successfully updated.' }
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, flash: { info: 'User was successfully deleted.' }
  end

  def forgot_password
    if request.post?
      user = User.find_by(username: params[:user][:username])
      user.send_password_reset if user
      redirect_to login_admin_users_url, flash: { info: 'We have sent an email with password reset instructions.' }
    end
  end

  def recover_password
    @user = User.find_by!(password_reset_token: params[:token])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to forgot_password_admin_users_url, flash: { danger: 'Sorry, the URL has expired. Please try again.' }
    elsif request.post? && @user.update_attributes(password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
      redirect_to login_admin_users_url, flash: { success: 'Your password has been reset. Please login below.' }
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :username, :main_boss, :store_boss, :workshop_user, :outlet_id, :email, :phone, :password, :password_confirmation, :address, :pincode, :city, :state, :country,permission_ids: [], role_ids: [])
    end
end
