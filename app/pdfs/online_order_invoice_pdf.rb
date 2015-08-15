class OnlineOrderInvoicePdf < Prawn::Document
	def initialize(order, view)
		@view = view
		super(top_margin: -10)
		image "#{Rails.root}/app/assets/images/invoice-header.jpg", width: 620, height: 100, position: -40
		pad(5){ text"Invoice", align: :center , size: 14 }
		width, height = 540, 110
		x, y=  0, 640
		stroke_rectangle [0, y], width, height
		text_box "Buyer", at: [x + 10, y - 5], width: width - 20, size: 8
		text_box "#{order.customer.name}" ,at:[x+ 10, y - 15] , size: 12, style: :bold
		text_box "#{order.customer.address}" ,at:[x + 10, y - 40] , size: 10
		text_box "#{order.customer.city}, #{order.customer.state}" ,at:[x + 10, y - 50] , size: 10
		text_box "#{order.customer.pincode}", at:[x + 10, y - 60] , size: 10
		text_box "Mobile: #{order.customer.mobile}" ,at:[x + 10, y - 75] , size: 10
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
		text_box "DDG/#{'%04i' % order.id}", at: [vertical_split_one + 5, y - 15], size: 10, style: :bold
		text_box "Dated:", at: [vertical_split_two + 5, y - 5], size: 10
		text_box "#{order.created_at.strftime('%d-%b-%Y')}", at: [vertical_split_two + 5, y - 15], size: 10, style: :bold
		text_box "Order No:", at: [vertical_split_one + 5, y - 35], size: 10
		text_box "DDG/#{'%04i' % order.id}", at: [vertical_split_one + 5, y - 45], size: 10, style: :bold
		text_box "Mode of Payment:", at: [vertical_split_two + 5, y - 35], size: 10
		text_box "Online", at: [vertical_split_two + 5, y - 45], size: 10, style: :bold
		text_box "Terms of Delivery", at: [vertical_split_one + 5, y - 65], size: 10
		move_down height
		line_items(order)
		y = 206
		height = 130
		stroke_rectangle [0, y], width, height
		text_box "Amount Chargeable (In Words)", at: [x + 10, y - 5], size: 10
		text_box "E. & O.E.", at: [vertical_split_two + 10, y - 5], size: 10, align: :right, style: :italic
		text_box "Rs. #{order.total_in_words} Only", at: [x + 10, y - 15], size: 10, style: :bold

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
	def line_items(order)
		table line_item_rows(order), width: 540 do
			row(0).font_style = :bold
			row(0).font_size = 8
			columns(1..4).align = :right
			columns(0..4).borders = [:left, :right]
			row(0).borders = [:left, :bottom, :right]
			row(0).borders = [:left, :bottom, :right]
			row(-1).font_style = :bold
			row(-1).borders = [:top, :left, :bottom, :right]
			tax_row = order.items.size+2
			row(tax_row).height = 180
			row(tax_row).align = :right
			row(-1).align = :right
			columns(0).width = 240
			self.header = true
		end
	end
	def line_item_rows(order)
		items = [['Description of Goods', 'Tax %', 'Quantity', 'Rate', 'Amount']]
		order.items.each do |item|
			amount = item.price * item.quantity
			items << [item.name, '', "#{item.quantity} #{product_type(item.product)}", @view.number_to_currency(item.price), @view.number_to_currency(amount)]
		end
		items << ['Subtotal','', '', '', @view.number_to_currency(order.subtotal)]
		items += tax_rows(order)
		items << ['Final Total', '', '', '',@view.number_to_currency(order.total)]
	end
	def product_type(product)
		product.is_a?(ProductGroup) ? 'Sets' : 'Nos'
	end
	def tax_rows(order)
		taxes = []
		order.taxes.each do |tax|
			taxes << [tax.name,"#{tax_percent(order)}%", '', '', @view.number_to_currency(tax.amount)]
		end
		taxes
	end
	def tax_percent(order)
		((order.total- order.subtotal) * 100 / order.subtotal).round(2)
	end
end
