class DcPdf < Prawn::Document
	def initialize(invoice, view)
		@view = view
		super(top_margin: 20)
		width = 540
		x, y=  0, 720
		text_box "GATE PASS", at: [0, y - 15], align: :center
		stroke {
		 horizontal_line x, width, at: y - 40
		 horizontal_line x, width, at: y
		}

		text_box "#{invoice.customer.name}" ,at:[x + 10, y - 75], style: :bold
		text_box "#{invoice.customer.address}" ,at:[x + 10, y - 90]
		text_box "#{invoice.customer.city}, #{invoice.customer.state}" ,at:[x + 10, y - 105]
		text_box "#{invoice.customer.pincode}", at:[x + 10, y - 120]
		text_box "Email: #{invoice.customer.email}" ,at:[x + 10, y - 135]
		text_box "Mobile: #{invoice.customer.mobile}" ,at:[x + 10, y - 150]


		text_box "No: #{invoice.id}", at: [x + 400, y - 105]
		text_box "Dated: #{Time.zone.now.strftime('%d-%b-%Y')}", at: [x + 400, y - 120]

		stroke {
		 horizontal_line x, width, at: y - 175
		 horizontal_line x, width, at: y - 200
		}
		text_box "Description", at: [x + 10, y - 183]
		text_box "Quantity", at: [x + 400, y - 183]

		total, total_quantity, spacer = 0, 0, 0
		invoice.orders.each do |order|
			order.items.each do |item|
				spacer += 20
				amount = item.price * item.quantity
				total += amount
				total_quantity += item.quantity
				text_box item.name, at: [x + 10, y - 193 - spacer]
				text_box "#{item.quantity} Nos", at: [x + 400, y - 193 - spacer]
			end
		end
		text_box 'TOTAL Quantity', at: [x + 10, y - spacer - 229], style: :bold
		text_box "#{total_quantity} Nos", at: [x + 400, y - spacer - 229]
		stroke {
		 horizontal_line x, width, at: y - spacer - 220
		 horizontal_line x, width, at: y - spacer - 245
		}
		text_box 'Amount', at: [x + 10, y - spacer - 254], style: :bold
		text_box @view.number_to_currency(total), at: [x + 400, y - spacer - 254]
		spacer += 50
		text_box 'Received the material in good condition', at: [x + 10, y - spacer - 250]
		text_box 'Authorized Signatory', at: [x + 400, y - spacer - 250]
		text_box 'Cutomer Signatory', at: [x + 10, y - spacer - 320]
		text_box "for Damian De Goa", at: [x + 400, y - spacer - 320], style: :italic
		stroke {
		 horizontal_line x, width, at: y - spacer - 220
		 horizontal_line x, width, at: y - spacer - 410
		}
		text_box "Furniture for fine living", at: [x + 10, y - spacer - 390], align: :center, size: 15
		text_box '903/1. Damian House, Porvorim, Bardez - Goa 403501', at: [x + 10, y - spacer - 430], align: :center
		text_box 'Phone 241746,2412126,2413737 Fax : 0832 2422127 Email: contact@damiandegoa.com', at: [x + 10, y - spacer - 445], align: :center
	end
end
