class OnlineOrderPdf < Prawn::Document
	def initialize(order, view)
		@view = view
		super(top_margin: 40)
		pad(10){ text"Order Details", align: :center,size: 18 }
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
			move_down 10
			transparent(0.5) { stroke_bounds }
		end
		line_items(order)
		stroke_horizontal_rule
		move_down 10
		total_items(order)
		move_down order.items.size * 20

		text_box "VAT TIN : 30660301642", at: [0, 420 ]
		text_box "CST No. : B/CST/2701 DTD 10-06-1963", at: [0, 400 ]
		text_box "Declaration", at: [0, 380 ], size: 8
		text_box "Warranty : Warranty coverage applies only to defects in products that are used exclusively for", at: [0, 360 ], size: 8
		text_box "personal,family or household purpose by original purchaser.Warranty covers the following from the", at: [0, 350 ], size: 8
		text_box "•One year Warranty against framework and any manufacturing defects in foam and polishing.", at: [0, 340 ], size: 8
		text_box "•Three years warranty against framework & workmanship on handcrafted furniture.", at: [0, 330 ], size: 8
		text_box "•Ten years warranty on mechanism for LAZBOY recliners.", at: [0, 320 ], size: 8
		text_box "•Fabric/Leather is not covered under any kind of warranty", at: [0, 310 ], size: 8
		text_box "Goods once sold will not be taken back.", at: [0, 300 ], size: 8
		text_box "THIS IS A COMPUTER GENERATED INVOICE. NO SIGNATURE REQUIRED", at: [0, 280 ], size: 10

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
		rows = [["Subtotal","#{@view.number_to_currency(order.subtotal)}"]]
		rows += tax_rows(order)
		rows << ["Grand Total","#{@view.number_to_currency(order.total)}"]
	end
	def tax_rows(order)
		taxes = []
		order.taxes.each do |tax|
			taxes << [tax.name, @view.number_to_currency(tax.amount)]
		end
		taxes
	end
end
