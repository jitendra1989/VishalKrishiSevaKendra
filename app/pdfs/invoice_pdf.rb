class InvoicePdf < Prawn::Document
	def initialize(invoice, view)
		@view = view
		super(top_margin: 30)
		text "Tax Invoice", align: :center , size: 12, style: :bold
		width, height = 540, 110
		xxx, y =  10, 720
		row_height = 32
		table [ [seller_info, order_info(invoice, row_height)], [buyer_info(invoice), despatch_info(invoice, row_height)]], cell_style: { inline_format: true, border_color: 'cccccc' } do
			 row(-1).height = row_height * 4
		end
		y = 500
		# table data, :cell_style => { :overflow => :shrink_to_fit, :min_font_size => 8, :width => 60, :height => 30 }
		# stroke_axis
		# bottom_line = cursor
		# stroke {
		#  horizontal_line 0, width, at: bottom_line
		# }
		stroke_color "cccccc"
		line_items(invoice)
		move_down 5
		y = cursor
		stroke {
			 vertical_line y + 5, y - 20 ,at: 0
			 vertical_line y + 5, y - 20 ,at: 540
		}
		text_box "Amount Chargeable (In Words)", at: [5, y], size:8
		text_box "E. & O.E.", at: [0, y], size: 10, align: :right, style: :italic
		text_box "Indian Rupees #{invoice.total_in_words} Only", at: [5, y - 10], size: 8, style: :bold
		move_down 20
		tax_table(invoice)
		y = cursor
		text_box "Tax Amount (in words) : <b>#{invoice.total_in_words} Only<b>", at: [5, y - 10], :inline_format => true, size: 8
		# text_box "on the first move the cursor went down to: #{cursor}", at: [5, y - 15], size: 8
		move_down 20
		y = cursor

		if y - 150 > 0
			text_box "Company's PAN 	 : ", at: [5, y - 20], size: 8
			text_box "AAMFD1447N", at: [80, y - 20], size: 8, style: :bold
			text_box "Declaration", at: [5, y - 30], size: 8
			text_box "Warranty : Warranty coverage applies only to defects in products that are used exclusively for", at: [5, y - 40], size: 8
			text_box "personal,family or household purposes by original purchaser.Warranty covers the following from the date of delivery", at: [5, y - 50], size: 8
			text_box "1. One year Warranty against framework and any manufacturing defects in foam and polishing.", at: [5, y - 60], size: 8
			text_box "2. Three years warranty against framework & workmanship on handcrafted furniture.", at: [5, y - 70], size: 8
			text_box "3. Ten years warranty on Mechanism LAZBOY recliners.", at: [5, y - 80], size: 8
			stroke {
				 vertical_line y - 90, y - 125 ,at: 270
				 vertical_line y + 20, y - 125 ,at: 0
				 vertical_line y + 20, y - 125 ,at: 540
				 horizontal_line 0, width, at: y - 89
				 horizontal_line 0, width, at: y - 125
			}

			text_box "Customer's Seal and Signature", at: [5, y - 91 ], size: 8
			text_box "for DAMIAN(GOA)", at: [470, y - 91], size: 8, style: :bold
			text_box "Authoried Signatory", at: [467, y - 114], size: 8
			text_box "This is a Computer Generated Invoice", at: [5, y - 132], size: 8, align: :center
		else
			# text_box "on the first move the cursor went down to: #{cursor}", at: [5, y ], size: 8
			stroke {
			 vertical_line y + 20, y - y ,at: 0
			 vertical_line y + 20, y - y,at: 540
			}

			start_new_page
			# stroke_axis
			y = cursor
			text_box "Company's PAN 	 : ", at: [5, y - 20], size: 8
			text_box "AAMFD1447N", at: [80, y - 20], size: 8, style: :bold
			text_box "Declaration", at: [5, y - 30], size: 8
			text_box "Warranty : Warranty coverage applies only to defects in products that are used exclusively for", at: [5, y - 40], size: 8
			text_box "personal,family or household purposes by original purchaser.Warranty covers the following from the date of delivery", at: [5, y - 50], size: 8
			text_box "1. One year Warranty against framework and any manufacturing defects in foam and polishing.", at: [5, y - 60], size: 8
			text_box "2. Three years warranty against framework & workmanship on handcrafted furniture.", at: [5, y - 70], size: 8
			text_box "3. Ten years warranty on Mechanism LAZBOY recliners.", at: [5, y - 80], size: 8
			stroke {
				 vertical_line y - 90, y - 125 ,at: 270
				 vertical_line y + 20, y - 125 ,at: 0
				 vertical_line y + 20, y - 125 ,at: 540
				 horizontal_line 0, width, at: y - 89
				 horizontal_line 0, width, at: y - 125
			}

			text_box "Customer's Seal and Signature", at: [5, y - 91 ], size: 8
			text_box "for DAMIAN(GOA)", at: [470, y - 91], size: 8, style: :bold
			text_box "Authoried Signatory", at: [467, y - 114], size: 8
			text_box "This is a Computer Generated Invoice", at: [5, y - 132], size: 8, align: :center

		end
	end

	def line_items(invoice)
		items_size, taxes_size = 0, 0
		invoice.orders.each do |order|
			items_size += order.items.size
			taxes_size = [taxes_size, order.taxes.size].max
		end

		table line_item_rows(invoice), width: 540, cell_style: { size: 10 } do
			columns(0..7).align = :center
			columns(0..7).borders = [:left, :right]
			columns(0..7).border_color= 'cccccc'
			row(0).borders = [:left, :bottom, :right]
			row(-1).font_style = :bold
			row(-1).borders = [:top, :left, :bottom, :right]
			row(-1).border_color= 'cccccc'
			tax_row_from = items_size + 2
			tax_row_to = tax_row_from + taxes_size - 1
			row(tax_row_from..tax_row_to).align = :right
			row(tax_row_to).height = 40
			row(-3).align = :right
			row(-2).height = 50
			columns(0).width = 25
			columns(1).width = 160
			columns(6).width = 32
			columns(7).width = 55
			self.header = true
		end
	end
	def line_item_rows(invoice)
		items = [['SI No','Description of Goods','HSN/SAC','GST Rate', 'Quantity', 'Rate', 'per','Amount']]
		invoice.orders.each_with_index do |order, i|
			order.items.each_with_index do |item, i|
				amount = item.price * item.quantity
				items << ['1',item.name, '9401', '',"#{item.quantity} #{product_type(item.product)}", item.price,"#{product_type(item.product)}",amount]
			end
		end
		# items << ['1','item.name', '9401', '',"{item.quantity} {product_type(item.product)}", 'item.price',"{product_type(item.product)}",'amount']
		# items << ['1','item.name', '9401', '',"{item.quantity} {product_type(item.product)}", 'item.price',"{product_type(item.product)}",'amount']
		# items << ['1','item.name', '9401', '',"{item.quantity} {product_type(item.product)}", 'item.price',"{product_type(item.product)}",'amount']
		# items << ['','SubTotal','', '', '', '','',invoice.orders.sum(:subtotal)]
		items += tax_rows(invoice.orders)
		items << ['','Total', '', '', '','','',invoice.total]
	end

	def tax_table(invoice)
		items_size, taxes_size = 0, 0
		invoice.orders.each do |order|
			items_size += order.items.size
			taxes_size = [taxes_size, order.taxes.size].max
		end
		table tax_table_rows(invoice), width: 540, cell_style: { height: 25 } do
			columns(0..6).align = :center
			columns(0..6).border_color= 'cccccc'
			columns(0).width = 160
			columns(1).width = 55
			columns(6).width = 55
			self.header = true
		end
	end
	def tax_table_rows(invoice)
		tax = [
			 [{:content => "HSN/SAC", :rowspan => 2}, {:content => "Taxable Value", :rowspan => 2}, {:content => "Central Tax", :colspan => 2}, {:content => "State Tax", :colspan => 2}, {:content => "Total Tax Amount", :rowspan => 2},],
			 ["Rate", "Amount", "Rate", "Amount"]
			]
		tax += tax_rows_info(invoice.orders)
	end
	def product_type(product)
		product.is_a?(ProductGroup) ? 'Sets' : 'Nos'
	end

	def tax_rows_info(orders)
		taxes, tax_array = {}, []
		orders.each do |order|
			order.taxes.each do |tax|
				taxes[tax.name] ||= { amount: 0, percentage: 0 }
				taxes[tax.name][:amount] += tax.amount
				taxes[tax.name][:percentage] = tax.percentage
			end
		end
		taxes.each do |tax|
			tax_array << ['9801','',"#{tax.second[:percentage]}%",tax.second[:amount],'','','']
		end
		tax_array
		tax_array << ['Total','','','','','','']
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
			tax_array << ['', "#{tax.first} #{tax.second[:percentage]}%(OUTPUT)",'','','',"#{tax.second[:percentage]}",'%',tax.second[:amount]]
		end
		tax_array
	end

	def seller_info
		'<font size="10"><strong>DAMIAN (GOA)</strong></font><br/><font size="10">H. No 406/51, Valentine Villa<br/>Nova Cidade Plots, Alto Porvorim, Goa<br/>GSTIN/UIN: 30AAMFD1447N1ZE<br/>E-mail: goadamian@gmail.com</font>'
	end

	def buyer_info(invoice)
		"<font size='10'>Buyer</font><br/><font size='10'><strong>#{invoice.customer.name}</strong><br/>#{invoice.customer.address}#{invoice.customer.city}<br/>State Name: #{invoice.customer.state}<br/>Place of Supply: #{invoice.customer.state}<br/><br/>Contact: #{invoice.customer.mobile}</font>"
	end

 	def order_info(invoice, row_height)
       width = 250
        make_table [ [make_cell(:content => "<font size='8'>Invoice No.</font><br/><font size='8'><strong>DDG/#{'%04i' % invoice.id}</strong>"),make_cell(:content => "<font size='8'>Dated</font><br/><font size='8'><strong>#{invoice.created_at.strftime('%d-%b-%Y')}</strong>")],
        		[make_cell(:content => "<font size='8'>Delivery Note</font><br/><br/>"),make_cell(:content => "<font size='8'>Mode/Terms of Payment</font>")],
        		[make_cell(:content => "<font size='8'>Supplier's Ref.</font><br/><br/>"),make_cell(:content => "<font size='8'>Other Reference(s)</font>")]
        		   ], cell_style: { inline_format: true, border_color: 'cccccc', height: row_height }, width: width
   end

   def despatch_info(invoice, row_height)
       width = 250
        make_table [[make_cell(:content => "<font size='8'>Buyer's Order No.</font><br/>		<br/>"),make_cell(:content => "<font size='8'>Dated</font>")],
        			[make_cell(:content => "<font size='8'>Despatch Document No.</font><br/><br/>"),make_cell(:content => "<font size='8'>Delivery Note Date</font>")],
 		       		[make_cell(:content => "<font size='8'>Despatched through</font><br/><font size='8'><strong>Van</strong>"),make_cell(:content => "<font size='8'>Destination</font><br/><font size='8'><strong>#{invoice.customer.city}</strong>")],
 		       		[make_cell(:content => "<font size='8'>Terms of Delivery</font>", :colspan => 2, :rowspan => 3)],
        		   ],:column_widths => [120.5, 129.5], cell_style: { inline_format: true, border_color: 'cccccc', height: row_height }, width: width
   end
end