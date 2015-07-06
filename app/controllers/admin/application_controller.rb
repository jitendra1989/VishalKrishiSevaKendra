class Admin::ApplicationController < ApplicationController
	include Admin::Sessions
	before_action :require_login

	private
		def require_login
			redirect_to login_admin_users_url unless logged_in?
		end
end
