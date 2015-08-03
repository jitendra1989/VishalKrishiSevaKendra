class InvoicePdf < Prawn::Document
	def initialize(invoice, view)
		@view = view
		super(top_margin: 40)
		pad(10){ text"Invoice", align: :center,size: 18 }
		bounding_box([0, 690], width: 540, height: 100) do
			move_down 20
			font "Helvetica"
			text_box "Buyer" ,at:[10,90] , size: 8
			move_down 5
			text_box "#{invoice.customer.name}" ,at:[10,80] , size: 12, style: :bold
			move_down 5
			text_box "#{invoice.customer.address}" ,at:[10,60] , size: 10
			text_box "#{invoice.customer.city}" ,at:[10,50] , size: 10
			text_box "#{invoice.customer.state}" ,at:[10,40] , size: 10
			text_box "Pincode :#{invoice.customer.pincode}" ,at:[10,30] , size: 10
			move_down 20
			text_box "Phone #{invoice.customer.mobile}" ,at:[10,20] , size: 10
			text_box "Invoice Number :#{invoice.id}", at: [120, 90], size: 10
			text_box "Order No :#{invoice.order_ids.join (',')}", at: [120, 80], size: 10
			text_box "Terms of Delivery :#{invoice.customer.created_at.strftime('%d-%m-%Y')}", at: [120, 70], size: 10
			text_box "Dated :#{invoice.customer.created_at.strftime('%d-%m-%Y')}", at: [300, 90], size: 10
			text_box "Mode/Terms of Payment :", at: [300, 80], size: 10
			move_down 10
			transparent(1) { stroke_bounds }
		end

		product_count = 0
		line_items(invoice)
		text_box "for Damian de Goa", style: :bold, at: [420, 180 ], size: 8
		text_box "Authorized Signatory", at: [420, 150 ], size: 8
		text_box "Companys VAT TIN : 30660301642", at: [0, 110 ], size: 8
		text_box "Companys CST No. : B/CST/2701 DTD 10-06-1963", at: [0, 100 ], size: 8
		text_box "Declaration", at: [0, 90 ], size: 8
		text_box "Warranty : Warranty coverage applies only to defects in products that are used exclusively for", at: [0, 80 ], size: 8
		text_box "personal,family or household purpose by original purchaser.Warranty covers the following from the", at: [0, 70 ], size: 8
		text_box "date of delivery:", at: [0, 60 ], size: 8
		text_box "•One year Warranty against framework and any manufacturing defects in foam and polishing.", at: [0, 50 ], size: 8
		text_box "•Three years warranty against framework & workmanship on handcrafted furniture.", at: [0, 40 ], size: 8
		text_box "•Ten years warranty on mechanism for LAZBOY recliners.", at: [0, 30 ], size: 8
		text_box "•Fabric/Leather is not covered under any kind of warranty", at: [0, 20 ], size: 8
		text_box "Goods once sold will not be taken back.", at: [0, 10 ], size: 8
	end
	def line_items(invoice)
		table line_item_rows(invoice), width: 540 do
			row(0).font_style = :bold
			columns(1..4).align = :right
			self.header = true
		end
	end
	def line_item_rows(invoice)
		total, total_quantity = 0, 0
		items = [['Description of Goods', 'Tax %', 'Quantity', 'Rate', 'Amount']]
		invoice.orders.each do |order|
			order.items.each do |item|
				amount = item.price * item.quantity
				total += amount
				total_quantity += item.quantity
				items << [item.name, '', item.quantity, @view.number_to_currency(item.price), @view.number_to_currency(amount)]
			end
		end

		items << ['Final Total','',total_quantity,'',@view.number_to_currency(total)]
	end

end