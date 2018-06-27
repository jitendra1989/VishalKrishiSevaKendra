class QuotationPdf < Prawn::Document
	def initialize(quotation)
		super(top_margin: 60)
		width = 541
		x, y =  0, 720
		image "#{Rails.root}/app/assets/images/new-logo-text.jpg", scale: 0.75, position: :center
		# stroke_axis
		move_down 10
		text "QUOTATION FORM", align: :center, size: 10, style: :bold,font: "Helvetica"

		name_width = width - 140
		formatted_text_box [
			{ text: quotation.customer.name },
		], at: [x + 10, y - 100], size: 8
		formatted_text_box [
			{ text: quotation.customer.full_address },
		], at: [x + 10, y - 120], size: 8
		stroke {
			horizontal_line x + 0, name_width, at: y - 110
			horizontal_line x + 432, width, at: y - 110
			horizontal_line x+ 0, width, at: y - 130
			horizontal_line x + 0, name_width, at: y - 145
			horizontal_line x + 445, width, at: y - 145
			horizontal_line x + 0, width, at: y - 159
		}

		formatted_text_box [
			{ text: "Date: " },
			{ text: quotation.customer.created_at.strftime('%d-%m-%Y') },
		], at: [x + 410, y - 100], size: 8
		formatted_text_box [
			{ text: "Dely. Date: " },
		], at: [x + 405, y - 135], size: 8
		formatted_text_box [
			{ text: "Phone/Fax: " },
		], at: [x + 350, y - 150], size: 8

		move_down 71
		line_items(quotation)
		stroke_horizontal_rule
		# text "the cursor is here: #{cursor}"
		# total = 0
		# move_down quotation.products.size * 20
		# text_box "ADVANCES REQUIRED", size: 8, style: :bold, at: [10, 300 - (20 * quotation.products.size)]
		# text_box "1.___50%______", size: 8, at: [10, 290 - (20 * quotation.products.size)]
		# text "the cursor is here: #{cursor}"
		y = cursor
		
		if y - 150 > 0
			text_box "For Damian Goa", size: 8, style: :bold, at: [420, cursor - 10]
			text_box "Manager", size: 8, at: [440, cursor - 115]
			stroke {
				 vertical_line y , y - 155 ,at: 0
				 vertical_line y , y - 155,at: 540
				  horizontal_line 0, 540, at: y - 155
			}
			text_box "<u><color rgb='cc0000'>PAYMENT TERMS</color></u>", :inline_format => true,size: 8, at: [120, cursor - 10],style: :bold
			text_box "50% advance against the order, balanace 50% payment before the delivery.", size: 8, at: [5, cursor - 25]
			text_box "In case of cheque payment, delivery will be after realization of the cheque.", size: 8, at: [5, cursor - 40]
			text_box "Goods once sold will not be taken back or exchanged.", size: 8, at: [5, cursor - 55]
			text_box "In case of cancellation of order, advance received is non refundable.", size: 8, at: [5, cursor - 70]
			text_box "Fabric, Polish shade, design and dimension will not be changed once the order is confirmed.", size: 8, at: [5, cursor - 85]
			text_box "Excise Duty, VAT, service tax will be charged extra if and as is applicable at the time of delivery.", size: 8, at: [5, cursor - 100]
			text_box "All the disputes are subjected to Panjim jurisdiction.", size: 8, at: [5,cursor - 115]
			text_box "Above terms and conditions are approved by me.", size: 8, at: [5, cursor - 145]
			move_down cursor
		else
			start_new_page
			text_box "For Damian Goa", size: 8, style: :bold, at: [420, cursor - 10]
			text_box "Manager", size: 8, at: [440, cursor - 115]
			stroke {
				 vertical_line cursor , cursor - 155 ,at: 0
				 vertical_line cursor , cursor - 155 ,at: 540
				  horizontal_line 0, 540, at: cursor - 155
			}
		
			text_box "<u><color rgb='cc0000'>PAYMENT TERMS</color></u>", :inline_format => true,size: 8, at: [120, cursor - 10],style: :bold
			text_box "50% advance against the order, balanace 50% payment before the delivery.", size: 8, at: [5, cursor - 25]
			text_box "In case of cheque payment, delivery will be after realization of the cheque.", size: 8, at: [5, cursor - 40]
			text_box "Goods once sold will not be taken back or exchanged.", size: 8, at: [5, cursor - 55]
			text_box "In case of cancellation of order, advance received is non refundable.", size: 8, at: [5, cursor - 70]
			text_box "Fabric, Polish shade, design and dimension will not be changed once the order is confirmed.", size: 8, at: [5, cursor - 85]
			text_box "Excise Duty, VAT, service tax will be charged extra if and as is applicable at the time of delivery.", size: 8, at: [5, cursor - 100]
			text_box "All the disputes are subjected to Panjim jurisdiction.", size: 8, at: [5,cursor - 115]
			text_box "Above terms and conditions are approved by me.", size: 8, at: [5, cursor - 145]
			
		end
	end

	def line_item_rows(quotation)
		items = [['Sr. No.', 'Description',	 'Quantity', 'Rate in Rupees', 'Value in Rupees', 'Total Amount']]

		count, total = 0, 0

		quotation.products.each_with_index do |product, index|
			# binding.pry
			count += 1
			amount = product.price * product.quantity
			items << [count, product.name, product.quantity, product.price, amount, amount]
			total += amount
		end
		# text "the cursor is here: #{cursor}"
		# text "the cursor is here: #{cursor}"
			# text_box "for Damian de Goa", style: :bold, at: [420, 400 - (20 * quotation.products.size)]
		# stroke_horizontal_rule
		# items << ['count',' product.name', 'product.quantity', 'product.price', 'amount', 'amount']
		# items << ['count',' product.name', 'product.quantity', 'product.price', 'amount', 'amount']
		# items << ['count',' product.name', 'product.quantity', 'product.price', 'amount', 'amount']
		# items << ['count',' product.name', 'product.quantity', 'product.price', 'amount', 'amount']
		# items << ['count',' product.name', 'product.quantity', 'product.price', 'amount', 'amount']
		# items << ['count',' product.name', 'product.quantity', 'product.price', 'amount', 'amount']
		
		items << ['ADVANCES REQUIRED', 'Total','','','','']
		quotation_tax_rows = tax_rows(quotation.products)
		items += quotation_tax_rows
		items << ['ADVANCES REQUIRED', 'SUBTOTAL','','','','']
		 # [{:content => "2x2", :colspan => 2, :rowspan => 2}, "F"],["G", "H"]
		 	# stroke_horizontal_rule
		 			# text_box "ADVANCES REQUIRED", size: 8, style: :bold, at: [10, 300 - (20 * quotation.products.size)]
		# text_box "1.___50%______", size: 8, at: [10, 290 - (20 * quotation.products.size)]
		items << [{:content => "ADVANCES REQUIRED 1.___50%______", :colspan => 3, :rowspan => 3},'Total','','']
		items << ['GST','','']
		items << ['G. Total','','']
		items
	end

	def tax_rows(products)
		taxes, tax_array = {}, []
		products.each do |product|
			product.product.tax_amount_breakup(product.product.price).each do |name, tax|
				taxes[name] ||= { amount: 0, percentage: tax[:percentage] }
				taxes[name][:amount] += tax[:amount]
			end
		end
		taxes.each do |tax|
			tax_array << ['', '', '', tax.first,"#{tax.second[:percentage]}%", tax.second[:amount]]
		end
		tax_array
	end

	def line_items(quotation)
		items_size = quotation.products.size
		table line_item_rows(quotation), width: 540 do
			row(0).font_style = :bold
			# table(data, :cell_style => {:padding => [0, 0, 0, 30]})
			row(0).font_size = 6
			columns(0..5).align = :right
			columns(1).align = :left
			columns(0..5).borders = [:left, :right]
			row(0).borders = [:left, :bottom, :right, :top]
			# row(-1).font_style = :bold
			# row(-1).borders = [:top, :left, :bottom, :right]
			row(-1).borders = [:left, :bottom, :right]
			# tax_row_from = items_size + 2
			# tax_row_to = tax_row_from + 0 - 1
			# row(tax_row_from..tax_row_to).align = :right
			row(-1).height = 40
			# row(-1).align = :right
			columns(0).width = 80
			# columns(1).width = 300
			# columns(2).width = 100
			# columns(3..5).width = 400
			self.header = true
		end
	end

end