class QuotationPdf < Prawn::Document
	def initialize(quotation)
		super(top_margin: 40)
		stroke_horizontal_rule
		pad(10){ text"Quotation Form", align: :center,size: 18 }
		stroke_horizontal_rule
		move_down 20
		font "Helvetica"
		text "#{quotation.customer.name}" , size: 12, style: :bold
		move_down 5
		text "#{quotation.customer.full_address}" , size: 10
		move_down 5
		text "Phone #{quotation.customer.mobile}" , size: 10
		text_box "Number #{quotation.id}", at: [450, 650], size: 10
		text_box "Date #{quotation.customer.created_at.strftime('%d-%m-%Y')}", at: [450, 630], size: 10
		move_down 10
		stroke_horizontal_rule
		text_box  "Description" , at: [0, 585], style: :bold
		text_box "Quantity" , at: [280, 585], style: :bold
		text_box "Rate" , at: [380, 585], style: :bold
		text_box "Amount" , at: [460, 585], style: :bold
		move_down 30
		stroke_horizontal_rule
		move_down 10
		total = 0
		quotation.products.each_with_index do |product, index|
			text_box "#{product.name}", at: [0, 560 - (20 * index)]
			text_box "#{product.quantity}", at: [280, 560 - (20 * index)]
			text_box "#{product.price}", at: [380, 560 - (20 * index)]
			amount = product.price * product.quantity
			total += amount
			text_box "#{amount}", at: [460, 560 - (20 * index)]
		end
		move_down quotation.products.size * 20
		stroke_horizontal_rule
		move_down 10
		text_box "Total", style: :bold, at: [0, 540 - (20 * quotation.products.size)]
		text_box "Discount", style: :bold, at: [0, 520 - (20 * quotation.products.size)]
		text_box "Final Total", style: :bold, at: [0, 500 - (20 * quotation.products.size)]
		move_down 10
		text_box "#{total}", style: :bold, at: [460, 540 - (20 * quotation.products.size)]
		text_box "#{quotation.discount_amount}", style: :bold, at: [460, 520 - (20 * quotation.products.size)]
		text_box "#{total - quotation.discount_amount}", style: :bold, at: [460, 500 - (20 * quotation.products.size)]
		move_down 60
		stroke_horizontal_rule
		text_box "for Damian de Goa", style: :bold, at: [420, 460 - (20 * quotation.products.size)]
		text_box "Authorized Signatory", at: [420, 400 - (20 * quotation.products.size)]
		text_box "TERMS & CONDITIONS FOR BUSINESS", style: :bold, at: [0, 380 - (20 * quotation.products.size)]
		text_box "Quotation Validity: One Month from the quotation date.", at: [0, 360 - (20 * quotation.products.size)]
		text_box "PAYMENT TERMS", at: [0, 340 - (20 * quotation.products.size)]
		text_box "50% Advance Against Order.", at: [0, 320 - (20 * quotation.products.size)]
		text_box "50% Balance Payments Before Delivery.", at: [0, 300 - (20 * quotation.products.size)]
		text_box "In case of cheque payment, delivery will be", at: [0, 280 - (20 * quotation.products.size)]
		text_box "after realization of the cheque.", at: [0, 260 - (20 * quotation.products.size)]
		text_box "In case of cancellation of order, advance", at: [0, 240 - (20 * quotation.products.size)]
		text_box "received is non refundable.", at: [0, 220 - (20 * quotation.products.size)]
		text_box "Excise Duty, VAT, service tax will be charged extra", at: [0, 200 - (20 * quotation.products.size)]
		text_box "if and as is applicable at the time of delivery.", at: [0, 180 - (20 * quotation.products.size)]
		text_box "All the disputes are subjected to Panjim jurisdiction.", at: [0, 160 - (20 * quotation.products.size)]
		text_box "Above terms and conditions are approved by me.", at: [0, 140 - (20 * quotation.products.size)]
		text_box "Client Signature", style: :bold, at: [0, 80 - (20 * quotation.products.size)]
	end
end
