module CustomersHelper
	def customer_log_in(customer)
		request.session[:customer_id] = customer.id
	end
end