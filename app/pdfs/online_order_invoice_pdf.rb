class OnlineOrderInvoicePdf < Prawn::Document
	def initialize(order, view)
		@view = view
		super(top_margin: 40)
		pad(10){ text"Invoice", align: :center,size: 14 }
		bounding_box([0, 690], width: 540, height: 100) do
			move_down 20
			font "Helvetica"
			text_box "Buyer:" ,at:[10,90] , size: 10
			move_down 5
			text_box "#{order.customer.name}" ,at:[10,80] , size: 12, style: :bold
			move_down 5
			text_box "#{order.customer.address}" ,at:[10,60] , size: 10
			text_box "#{order.customer.city}" ,at:[10,50] , size: 10
			text_box "#{order.customer.state}" ,at:[10,40] , size: 10
			text_box "Pincode :#{order.customer.pincode}" ,at:[10,30] , size: 10
			move_down 20
			text_box "Phone #{order.customer.mobile}" ,at:[10,20] , size: 10
			text_box "Invoice For Order ID :#{order.id}", at: [300, 90], size: 10
			text_box "Dated :#{order.customer.created_at.strftime('%d-%m-%Y')}", at: [300, 80], size: 10
			text_box "Mode/Terms of Payment : Online", at: [300, 70], size: 10
			move_down 10
			transparent(1) { stroke_bounds }
		end

		line_items(order)

		shift_factor = 20 * order.items.size
		text_box "Company's VAT TIN : 30660301642", at: [0 , 440 - shift_factor], size: 8
		text_box "Company's CST No. : B/CST/2701 DTD 10-06-1963", at: [0, 420 - shift_factor], size: 8
		text_box "Declaration", at: [0, 380 - shift_factor], size: 8
		text_box "Warranty : Warranty coverage applies only to defects in products that are used exclusively for", at: [0, 370 - shift_factor], size: 8
		text_box "personal,family or household purpose by original purchaser.Warranty covers the following from the", at: [0, 360 - shift_factor], size: 8
		text_box "•One year Warranty against framework and any manufacturing defects in foam and polishing.", at: [0, 350 - shift_factor], size: 8
		text_box "•Three years warranty against framework & workmanship on handcrafted furniture.", at: [0, 340 - shift_factor], size: 8
		text_box "•Ten years warranty on mechanism for LAZBOY recliners.", at: [0, 330 - shift_factor], size: 8
		text_box "•Fabric/Leather is not covered under any kind of warranty", at: [0, 320 - shift_factor], size: 8
		text_box "Goods once sold will not be taken back.", at: [0, 310 - shift_factor], size: 8
		text_box "THIS IS A COMPUTER GENERATED INVOICE. NO SIGNATURE REQUIRED", at: [0, 300 - shift_factor], size: 10
	end
	def line_items(order)
		table line_item_rows(order), width: 540 do
			row(0).font_style = :bold
			row(0).font_size = 8
			row(-1).font_style = :bold
			columns(1..4).align = :right
			self.header = true
		end
	end
	def line_item_rows(order)
		total, total_quantity = 0, 0
		items = [['Description of Goods', 'Quantity', 'Rate', 'Amount']]
		order.items.each do |item|
			amount = item.price * item.quantity
			total += amount
			total_quantity += item.quantity
			items << [item.name, item.quantity, @view.number_to_currency(item.price), @view.number_to_currency(amount)]
		end
		items += tax_rows(order)
		items << ['Final Total',total_quantity,'',@view.number_to_currency(total)]
	end
	def tax_rows(order)
		taxes = []
		order.taxes.each do |tax|
			taxes << [tax.name, '', '', @view.number_to_currency(tax.amount)]
		end
		taxes
	end

end
