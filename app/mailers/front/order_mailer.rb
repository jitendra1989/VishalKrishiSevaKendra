class Front::OrderMailer < ApplicationMailer

	def success(order)
		@order = order
		@customer = order.customer
		@recepient_name = @customer.name
		invoice = OnlineOrderPdf.new(@order, view_context)
		attachments["invoice_#{@order.id}.pdf"] = { mime_type: 'application/pdf', content: invoice.render }
		email_with_name = %("#{@recepient_name}" <#{@customer.email}>)
		mail to: email_with_name, subject: 'Your Order with Damian De Goa.'
	end
end
