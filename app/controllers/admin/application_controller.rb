class Admin::ApplicationController < ApplicationController
	include Admin::Sessions
	before_action :require_login

	rescue_from CanCan::AccessDenied, with: :access_denied

	def self.permission
		self.controller_name.classify
	end

	private
		def require_login
			redirect_to login_admin_users_url unless logged_in?
		end

		def access_denied
			redirect_to admin_root_url, flash: { danger: "You don't have access to this page!" }
		end
end