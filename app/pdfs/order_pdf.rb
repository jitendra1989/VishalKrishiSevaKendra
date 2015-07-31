class OrderPdf < Prawn::Document
	def initialize(order)
		super(top_margin: 40)
		pad(10){ text"Order Form", align: :center,size: 18 }
		bounding_box([0, 690], width: 540, height: 60) do
			move_down 20
			font "Helvetica"
			text_box "#{order.customer.name}" ,at:[10,50] , size: 12, style: :bold
			move_down 5
			text_box "#{order.customer.full_address}" ,at:[10,36] , size: 10
			move_down 5
			text_box "Phone #{order.customer.mobile}" ,at:[10,22] , size: 10
			text_box "Number :#{order.id}", at: [400, 50], size: 10
			text_box "Date :#{order.customer.created_at.strftime('%d-%m-%Y')}", at: [400, 36], size: 10
			text_box "Delivery Date :#{order.customer.created_at.strftime('%d-%m-%Y')}", at: [400, 22], size: 10
			move_down 10
			transparent(0.5) { stroke_bounds }
		end
		line_items(order)
		stroke_horizontal_rule
		move_down 10
		total_items(order)
		move_down order.items.size * 20
		move_down 10
		text_box "for Damian de Goa", style: :bold, at: [420, 460 - (20 * order.items.size)]
		text_box "Authorized Signatory", at: [420, 400 - (20 * order.items.size)]
		text_box "TERMS & CONDITIONS FOR BUSINESS", style: :bold, at: [0, 380 - (20 * order.items.size)]
		text_box "PAYMENT TERMS", at: [0, 340 - (20 * order.items.size)]
		text_box "50% Advance Against Order.", at: [0, 320 - (20 * order.items.size)]
		text_box "50% Balance Payments Before Delivery.", at: [0, 300 - (20 * order.items.size)]
		text_box "In case of cheque payment, delivery will be", at: [0, 280 - (20 * order.items.size)]
		text_box "after realization of the cheque.", at: [0, 260 - (20 * order.items.size)]
		text_box "In case of cancellation of order, advance", at: [0, 240 - (20 * order.items.size)]
		text_box "received is non refundable.", at: [0, 220 - (20 * order.items.size)]
		text_box "Excise Duty, VAT, service tax will be charged extra", at: [0, 200 - (20 * order.items.size)]
		text_box "if and as is applicable at the time of delivery.", at: [0, 180 - (20 * order.items.size)]
		text_box "Fabric, Polish shade, design and dimension will not be changed once the order is confirmed.", at: [0, 160 - (20 * order.items.size)]
		text_box "All the disputes are subjected to Panjim jurisdiction.", at: [0, 140 - (20 * order.items.size)]
		text_box "Above terms and conditions are approved by me.", at: [0, 120 - (20 * order.items.size)]
		text_box "Client Signature", style: :bold, at: [0, 60 - (20 * order.items.size)]
	end
	def line_items(order)
		table line_item_rows(order), width: 540 do
			row(0).font_style = :bold
			columns(1..4).align = :right
			self.row_colors = ["DDDDDD", "FFFFFF"]
			self.header = true
		end
	end
	def line_item_rows(order)
		[["Product", "Qty", "Rate", "Total"]]+
		order.items.map do |item|
			[item.name, item.quantity, item.price, item.quantity * item.price]
		end
	end
	def total_items(order)

		table total_item_rows(order), width: 540 do
			column(0).font_style = :bold
			columns(1).align = :right
			columns(0).width = 450
		end
	end
	def total_item_rows(order)
		total = 0
		order.items.each do |item|
			amount = item.price * item.quantity
			total += amount
		end
		[["Total","#{total}"],["Discount","#{order.discount_amount}"], ["Grand Total","#{total - order.discount_amount}"], ["Amount Paid",0], ["Amount Balance",0]]
	end
end
