class Front::ApplicationController < ApplicationController
	include Front::Sessions
	before_action :check_login

	private
		def check_login
			logged_in?
		end
end
