class Admin::UsersController < Admin::ApplicationController
  skip_before_action :require_login, only: [:login]
  load_and_authorize_resource

  def index
    @users = User.all
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

  private
    def user_params
      params.require(:user).permit(:name, :username, :outlet_id, :email, :phone, :password, :password_confirmation, :address, :pincode, :city, :state, :country,permission_ids: [], role_ids: [])
    end
end
