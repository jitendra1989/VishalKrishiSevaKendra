class Admin::UserMailer < ApplicationMailer
	def password_reset(user)
		@user = user
		@recepient_name = user.name
		email_with_name = %("#{@recepient_name}" <#{@user.email}>)
		mail to: email_with_name, subject: 'Reset password for Damian De Goa Admin'
	end
end
