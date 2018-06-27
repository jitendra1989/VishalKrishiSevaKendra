class OrderPdf < Prawn::Document
	def initialize(order, view)
		@view = view
		super(top_margin: 30)
		image "#{Rails.root}/app/assets/images/new-logo-text.jpg", scale: 0.75, position: :center
		pad(10){ text"Order Form", align: :center,size: 18 }
		bounding_box([0, 660], width: 540, height: 60) do
			move_down 20
			font "Helvetica"
			text_box "#{order.customer.name}" ,at:[10,50] , size: 12, style: :bold
			move_down 5
			text_box "#{order.customer.full_address}" ,at:[10,36], size: 10
			move_down 5
			text_box "Phone #{order.customer.mobile}" ,at:[10,22], size: 10
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
		text_box "for Damian de Goa", style: :bold, at: [420, 380 - (20 * order.items.size)]
		text_box "Authorized Signatory", at: [420, 340 - (20 * order.items.size)]
		text_box "TERMS & CONDITIONS FOR BUSINESS", style: :bold, at: [0, 380 - (20 * order.items.size)]
		text_box "PAYMENT TERMS", at: [0, 340 - (20 * order.items.size)], size: 10
		text_box "50% Advance Against the Order.", at: [0, 325 - (20 * order.items.size)], size: 10
		text_box "50% Balance Payments Before Delivery.", at: [0, 310 - (20 * order.items.size)], size: 10
		text_box "In case of cheque payment, delivery will be", at: [0, 295 - (20 * order.items.size)], size: 10
		text_box "after realization of the cheque.", at: [0, 280 - (20 * order.items.size)], size: 10
		text_box "Goods once sold will not be taken back or exchanged.", at: [0, 265 - (20 * order.items.size)], size: 10
		text_box "In case of cancellation of order, advance", at: [0, 250 - (20 * order.items.size)], size: 10
		text_box "received is non refundable.", at: [0, 235 - (20 * order.items.size)], size: 10
		text_box "Excise Duty, VAT, service tax will be charged extra", at: [0, 220 - (20 * order.items.size)], size: 10
		text_box "if and as is applicable at the time of delivery.", at: [0, 205 - (20 * order.items.size)], size: 10
		text_box "Fabric, Polish shade, design and dimension will not be changed once the order is confirmed.", at: [0, 190 - (20 * order.items.size)], size: 10
		text_box "All the disputes are subjected to Panjim jurisdiction.", at: [0, 175 - (20 * order.items.size)], size: 10
		text_box "Above terms and conditions are approved by me.", at: [0, 160 - (20 * order.items.size)], size: 10
		text_box "Client Signature", style: :bold, at: [0, 60 - (20 * order.items.size)]
	end
	def line_items(order)
		table line_item_rows(order), width: 540 do
			row(0).font_style = :bold
			columns(1..4).align = :right
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
		[["Subtotal","#{@view.number_to_currency(order.subtotal)}"], ["Tax","#{@view.number_to_currency(order.tax_amount)}"],['Gross Amount', "#{@view.number_to_currency(order.subtotal + order.tax_amount)}"],["Discount","#{@view.number_to_currency(-order.discount_amount)}"], ["Grand Total","#{@view.number_to_currency(order.total)}"], ["Amount Paid", @view.number_to_currency(order.receipts.pluck(:amount).sum)], ["Amount Balance", @view.number_to_currency(order.unpaid_amount)]]
	end
end
