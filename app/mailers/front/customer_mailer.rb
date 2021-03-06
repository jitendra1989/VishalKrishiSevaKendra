class Front::CustomerMailer < ApplicationMailer
	def welcome(customer_id)
		@customer = Customer.find(customer_id)
		@recepient_name = @customer.name
		email_with_name = %("#{@recepient_name}" <#{@customer.email}>)
		mail to: email_with_name, subject: 'Welcome to Damian De Goa! Please activate your account.'
	end

	def password_reset(customer_id)
		@customer = Customer.find(customer_id)
		@recepient_name = @customer.name
		email_with_name = %("#{@recepient_name}" <#{@customer.email}>)
		mail to: email_with_name, subject: 'Reset password for Damian De Goa Customer'
	end
end
