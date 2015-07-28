module Front::Sessions
	extend ActiveSupport::Concern
	private
		def log_in(customer)
			session[:customer_id] = customer.id
			session[:online_cart_id] = customer.set_online_cart(session[:online_cart_id])
		end

		def current_customer
			@current_customer ||= Customer.find_by(id: session[:customer_id])
		end

		def logged_in?
			!current_customer.nil?
		end

		def log_out
			@current_customer = session[:customer_id] = session[:online_cart_id] = nil
		end
end