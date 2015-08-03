class MailInterceptor
	def self.delivering_email(message)
		Rails.logger.warn "Emails are sent to #{ENV['INTERCEPTOR_EMAIL_TO']} email account from #{Rails.env} env"

		message.to = ENV['INTERCEPTOR_EMAIL_TO']
		message.cc = nil
		message.bcc = nil
		message.subject = "#{Rails.env}: #{message.subject}"
	end
end