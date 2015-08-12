class Front::ApplicationController < ApplicationController
	include Front::Sessions
	before_action :check_login

	private
		def check_login
			logged_in?
		end

		def require_activation
			require_login
			redirect_to login_front_customer_url, flash: { warning: 'Please activate your account by accessing your email.'} unless current_customer.activated?
		end

		def require_login
			redirect_to login_front_customer_url unless logged_in?
		end
end
