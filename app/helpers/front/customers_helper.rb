module Front::CustomersHelper
	def customer_logged_in?
		!@current_customer.nil?
	end
end
