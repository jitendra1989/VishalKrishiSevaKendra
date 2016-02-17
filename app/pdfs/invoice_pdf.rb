class InvoicePdf < Prawn::Document
	def initialize(invoice, view)
		@view = view
		super(top_margin: -10)
		image "#{Rails.root}/app/assets/images/invoice-header.jpg", width: 620, height: 100, position: -40
		pad(5){ text"Invoice", align: :center , size: 14 }
		width, height = 540, 110
		x, y=  0, 640
		stroke_rectangle [0, y], width, height
		text_box "Buyer", at: [x + 10, y - 5], width: width - 20, size: 8
		text_box "#{invoice.customer.name}" ,at:[x+ 10, y - 15] , size: 12, style: :bold
		text_box "#{invoice.customer.address}" ,at:[x + 10, y - 40] , size: 10
		text_box "#{invoice.customer.city}, #{invoice.customer.state}" ,at:[x + 10, y - 50] , size: 10
		text_box "#{invoice.customer.pincode}", at:[x + 10, y - 60] , size: 10
		text_box "Mobile: #{invoice.customer.mobile}" ,at:[x + 10, y - 75] , size: 10
		vertical_split_one = 250
		vertical_split_two = 400
		bottom_line = y - 60
		stroke {
		 vertical_line y, y - height, at: vertical_split_one
		 vertical_line y, bottom_line, at: vertical_split_two
		 horizontal_line 250, width, at: y - 30
		 horizontal_line 250, width, at: bottom_line
		}
		text_box "Invoice No:", at: [vertical_split_one + 5, y - 5], size: 10
		text_box "DDG/#{'%04i' % invoice.id}", at: [vertical_split_one + 5, y - 15], size: 10, style: :bold
		text_box "Dated:", at: [vertical_split_two + 5, y - 5], size: 10
		text_box "#{invoice.created_at.strftime('%d-%b-%Y')}", at: [vertical_split_two + 5, y - 15], size: 10, style: :bold
		text_box "Order No:", at: [vertical_split_one + 5, y - 35], size: 10
		text_box "DDG/#{invoice.order_ids.join (',')}", at: [vertical_split_one + 5, y - 45], size: 10, style: :bold
		text_box "Mode of Payment:", at: [vertical_split_two + 5, y - 35], size: 10
		text_box "Online", at: [vertical_split_two + 5, y - 45], size: 10, style: :bold
		text_box "Terms of Delivery", at: [vertical_split_one + 5, y - 65], size: 10
		move_down height
		line_items(invoice)
		y = 206
		height = 130
		stroke_rectangle [0, y], width, height
		text_box "Amount Chargeable (In Words)", at: [x + 10, y - 5], size: 10
		text_box "E. & O.E.", at: [vertical_split_two + 10, y - 5], size: 10, align: :right, style: :italic
		text_box "Rs. #{invoice.total_in_words} Only", at: [x + 10, y - 15], size: 10, style: :bold

		text_box "Company's VAT TIN : 30660301642", at: [x + 10 , y - 30], size: 10
		text_box "Company's CST No. : B/CST/2701 DTD 10-06-1963", at: [x + 10, y - 40], size: 8
		text_box "Declaration", at: [x + 10, y - 50], size: 8
		text_box "Warranty : Warranty coverage applies only to defects in products that are used exclusively for", at: [x + 10, y - 60], size: 8
		text_box "personal,family or household purpose by original purchaser.Warranty covers the following from the", at: [x + 10, y - 70], size: 8
		text_box "•One year Warranty against framework and any manufacturing defects in foam and polishing.", at: [x + 10, y - 80], size: 8
		text_box "•Three years warranty against framework & workmanship on handcrafted furniture.", at: [x + 10, y - 90], size: 8
		text_box "•Ten years warranty on mechanism for LAZBOY recliners.", at: [x + 10, y - 100], size: 8
		text_box "•Fabric/Leather is not covered under any kind of warranty", at: [x + 10, y - 110], size: 8
		text_box "•Goods once sold will not be taken back.", at: [x + 10, y - 120], size: 8
		text_box "THIS IS A COMPUTER GENERATED INVOICE. NO SIGNATURE REQUIRED", at: [x + 10, y - 135], size: 10, align: :center
		image "#{Rails.root}/app/assets/images/invoice-footer.jpg", width: 620, height: 100, at: [-40, y - 145]
	end
	def line_items(invoice)
		items_size, taxes_size = 0, 0
		invoice.orders.each do |order|
			items_size += order.items.size
			taxes_size = [taxes_size, order.taxes.size].max
		end
		table line_item_rows(invoice), width: 540 do
			row(0).font_style = :bold
			row(0).font_size = 8
			columns(1..4).align = :right
			columns(0..4).borders = [:left, :right]
			row(0).borders = [:left, :bottom, :right]
			row(0).borders = [:left, :bottom, :right]
			row(-1).font_style = :bold
			row(-1).borders = [:top, :left, :bottom, :right]
			tax_row_from = items_size + 2
			tax_row_to = tax_row_from + taxes_size - 1
			row(tax_row_from..tax_row_to).align = :right
			row(tax_row_to).height = 120
			row(-1).align = :right
			columns(0).width = 240
			self.header = true
		end
	end
	def line_item_rows(invoice)
		items = [['Description of Goods', 'Tax %', 'Quantity', 'Rate', 'Amount']]
		invoice.orders.each do |order|
			order.items.each do |item|
				amount = item.price * item.quantity
				items << [item.name, '', "#{item.quantity} #{product_type(item.product)}", @view.number_to_currency(item.price), @view.number_to_currency(amount)]
			end
		end
		items << ['Subtotal','', '', '', @view.number_to_currency(invoice.orders.sum(:subtotal))]
		items += tax_rows(invoice.orders)
		items << ['Final Total', '', '', '',@view.number_to_currency(invoice.total)]
	end
	def product_type(product)
		product.is_a?(ProductGroup) ? 'Sets' : 'Nos'
	end
	def tax_rows(orders)
		taxes, tax_array = {}, []
		orders.each do |order|
			order.taxes.each do |tax|
				taxes[tax.name] ||= { amount: 0, percentage: 0 }
				taxes[tax.name][:amount] += tax.amount
				taxes[tax.name][:percentage] = tax.percentage
			end
		end
		taxes.each do |tax|
			tax_array << [tax.first,"#{tax.second[:percentage]}%", '', '', @view.number_to_currency(tax.second[:amount])]
		end
		tax_array
	end










	# 	bounding_box([0, 690], width: 540, height: 100) do
	# 		move_down 20
	# 		font "Helvetica"
	# 		text_box "Buyer" ,at:[10,90] , size: 8
	# 		move_down 5
	# 		text_box "#{invoice.customer.name}" ,at:[10,80] , size: 12, style: :bold
	# 		move_down 5
	# 		text_box "#{invoice.customer.address}" ,at:[10,60] , size: 10
	# 		text_box "#{invoice.customer.city}" ,at:[10,50] , size: 10
	# 		text_box "#{invoice.customer.state}" ,at:[10,40] , size: 10
	# 		text_box "Pincode :#{invoice.customer.pincode}" ,at:[10,30] , size: 10
	# 		move_down 20
	# 		text_box "Phone #{invoice.customer.mobile}" ,at:[10,20] , size: 10
	# 		text_box "Invoice Number :#{invoice.id}", at: [120, 90], size: 10
	# 		text_box "Order No :#{invoice.order_ids.join (',')}", at: [120, 80], size: 10
	# 		text_box "Terms of Delivery :#{invoice.customer.created_at.strftime('%d-%m-%Y')}", at: [120, 70], size: 10
	# 		text_box "Dated :#{invoice.customer.created_at.strftime('%d-%m-%Y')}", at: [300, 90], size: 10
	# 		text_box "Mode/Terms of Payment :", at: [300, 80], size: 10
	# 		move_down 10
	# 		transparent(1) { stroke_bounds }
	# 	end

	# 	product_count = 0
	# 	line_items(invoice)
	# 	text_box "for Damian de Goa", style: :bold, at: [420, 180 ], size: 8
	# 	text_box "Authorized Signatory", at: [420, 150 ], size: 8
	# 	text_box "Companys VAT TIN : 30660301642", at: [0, 110 ], size: 8
	# 	text_box "Companys CST No. : B/CST/2701 DTD 10-06-1963", at: [0, 100 ], size: 8
	# 	text_box "Declaration", at: [0, 90 ], size: 8
	# 	text_box "Warranty : Warranty coverage applies only to defects in products that are used exclusively for", at: [0, 80 ], size: 8
	# 	text_box "personal,family or household purpose by original purchaser.Warranty covers the following from the", at: [0, 70 ], size: 8
	# 	text_box "date of delivery:", at: [0, 60 ], size: 8
	# 	text_box "•One year Warranty against framework and any manufacturing defects in foam and polishing.", at: [0, 50 ], size: 8
	# 	text_box "•Three years warranty against framework & workmanship on handcrafted furniture.", at: [0, 40 ], size: 8
	# 	text_box "•Ten years warranty on mechanism for LAZBOY recliners.", at: [0, 30 ], size: 8
	# 	text_box "•Fabric/Leather is not covered under any kind of warranty", at: [0, 20 ], size: 8
	# 	text_box "Goods once sold will not be taken back.", at: [0, 10 ], size: 8
	# end
	# def line_items(invoice)
	# 	table line_item_rows(invoice), width: 540 do
	# 		row(0).font_style = :bold
	# 		columns(1..4).align = :right
	# 		self.header = true
	# 	end
	# end
	# def line_item_rows(invoice)
	# 	total, total_quantity = 0, 0
	# 	items = [['Description of Goods', 'Tax %', 'Quantity', 'Rate', 'Amount']]
	# 	invoice.orders.each do |order|
	# 		order.items.each do |item|
	# 			amount = item.price * item.quantity
	# 			total += amount
	# 			total_quantity += item.quantity
	# 			items << [item.name, '', item.quantity, @view.number_to_currency(item.price), @view.number_to_currency(amount)]
	# 		end
	# 	end

	# 	items << ['Final Total','',total_quantity,'',@view.number_to_currency(total)]
	# end

end