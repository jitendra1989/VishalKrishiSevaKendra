class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:login]

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

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_url, success: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :username, :email, :phone, :password, :password_confirmation, :address, :pincode, :city, :state, :country)
    end
end
