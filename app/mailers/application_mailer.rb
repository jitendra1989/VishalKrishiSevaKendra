class ApplicationMailer < ActionMailer::Base
	before_filter :set_common_variables

	default from: ENV['FROM_ADDRESS'],
					reply_to: ENV['REPLY_TO_ADDRESS'],
					bcc: ENV['BCC_ADDRESSES']#.split(';')

	private
		def set_common_variables
			@common = { site_name: Rails.application.class.parent, reply_to: %(jrathor12@gmail.com), site_url: front_root_url }
		end
end
