class Front::CustomerMailer < ApplicationMailer
	def welcome(customer)
		@customer = customer
		@recepient_name = customer.name
		email_with_name = %("#{@recepient_name}" <#{@customer.email}>)
		mail to: email_with_name, subject: 'Welcome to Damian De Goa! Please activate your account.'
	end
end