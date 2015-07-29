class Front::OrdersController < Front::ApplicationController
	before_action :require_login
  def index
  end

  def new
  end

  private
  	def require_login
  		redirect_to login_front_customer_url unless logged_in?
  	end
end
