class GatePassPdf < Prawn::Document
	def initialize(invoice, view)
		@view = view
		super(top_margin: 10)
		width = 540
		x, y =  0, 720
		image "#{Rails.root}/app/assets/images/new-logo.png", scale: 0.75, position: :center
		move_down 12
		text "GATE PASS", size: 20, style: :bold, align: :center
		text_box "To", at: [x + 15, y - 80]
		name_width = width - 200
		formatted_text_box [
			{ text: "Client:" },
			{ text: invoice.customer.name },
		], at: [x + 10, y - 100]
 		stroke {

		 horizontal_line x + 45, name_width, at: y - 110
 		}
		formatted_text_box [
			{ text: " Date: " },
			{ text: Time.zone.now.strftime('%d-%b-%Y'), styles: [:underline] },
			{ text: " Time: " },
			{ text: Time.zone.now.strftime('%H:%M'), styles: [:underline] },
		], at: [name_width + 10, y - 100]
		formatted_text_box [
			{ text: "Place:" },
			{ text: "#{invoice.customer.address}, #{invoice.customer.city}, #{invoice.customer.state}, #{invoice.customer.pincode}", styles: [:underline] },
		], at: [x + 10, y - 125]
		move_down 70
		line_items(invoice)

	end

	def line_items(invoice)
		width = 540
		table line_item_rows(invoice), width: width do
					columns(0).align = :center
					columns(2).align = :right
					row(0).align = :center
					columns(0).width = 60
					columns(2).width = 80
			end
			move_down 20
			table [['Prepared', 'Passed', 'Authorized']], width: width do
					row(0).borders = []
					row(0).align = :center
			end
	end

	def line_item_rows(invoice)
		items = [['Sr. No.', 'Particulars', 'Qty.']]
		count = 0
		invoice.orders.each do |order|
			order.items.each do |item|
				count += 1
				items << [count, item.name, item.quantity]
			end
		end
		items
	end
end