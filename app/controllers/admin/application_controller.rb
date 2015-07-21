class Admin::ApplicationController < ApplicationController
	include Admin::Sessions
	before_action :require_login

	def self.permission
		self.controller_name.classify
	end

	private
		def require_login
			redirect_to login_admin_users_url unless logged_in?
		end
end
