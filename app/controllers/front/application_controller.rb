class Front::ApplicationController < ApplicationController
	include Front::Sessions
	before_action :check_login
	before_action :clear_blocked_stock

	private
		def check_login
			logged_in?
		end

		def require_activation
			redirect_to login_front_customer_url, flash: { warning: 'Please activate your account by accessing your email.'} unless current_customer.try(:activated?)
		end

		def require_login
			redirect_to login_front_customer_url unless logged_in?
		end

		def require_validation
			if logged_in?
				redirect_to edit_front_customer_url, flash: { warning: 'Please complete your profile.'}  unless current_customer.valid?
			else
				redirect_to login_front_customer_url
			end
		end

		def clear_blocked_stock
			if session[:blocked_stock_jid]
				scheduled_set = Sidekiq::ScheduledSet.new
				jobs = scheduled_set.select {|job| job.jid == session[:blocked_stock_jid] }
				jobs.each(&:add_to_queue)
				session[:blocked_stock_jid] = nil
			end
		end
end
