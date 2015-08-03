class ApplicationMailer < ActionMailer::Base
	before_filter :set_common_variables

	default from: 'Damian De Goa<no-reply@damiandegoa.com>',
					reply_to: 'Damian De Goa<info@damiandegoa.com>',
					bcc: ENV['BCC_ADDRESSES'].split(';')

	private
		def set_common_variables
			@common = { site_name: Rails.application.class.parent, reply_to: %(info@damiandegoa.com), site_url: front_root_url }
		end
end
