class ReceiptPdf < Prawn::Document
	def initialize(receipt)
		super(top_margin: 120)
		width, height = 540, 110
		 stroke do
		 	self.line_width = 2
		 	# stroke_axis
 			rectangle [0, y + 25], 540, 400
 				image "#{Rails.root}/app/assets/images/new-logo.png", scale: 0.20, position: :center
 				text_box "Phone: 2413737, 2412126, 2417045", at: [200, y - 40], size:8, position: :center
 				rectangle [370, 606], 170, 290
				rotate(90, :origin => [233, 220]) do
					draw_text "OFFICIAL RECEIPT", :size => 15, style: :bold,:at => [390, 88]
				 end
			
			 	move_down 12.5
				receipt_body_items(receipt)
				move_down 10
				text_box "towards the full/part/Advance payment against your order/ bills as under.",at: [5, 400],size:10
				text_box "Bill No",at: [5, 350],size:10
				text_box "Date",at: [150, 350],size:10
				text_box "Amount",at: [250, 350],size:10
				text_box "P.S. (I) All Payments by cheques are acknowledged subject to realisation.",at: [5, 305],size:8
				#
				stroke {
					horizontal_line  370, width , at: 570
					horizontal_line  370, width , at: 500
					horizontal_line  370, width , at: 420
					horizontal_line  395, width - 80, at: 480
 					rectangle [410, 380], 80, 50
 					horizontal_line  350, width - 170 , at: 606
					horizontal_line  350, width - 170, at: 316
				}
				text_box "Receipt No.:DG",at: [372, 565],size:10
				text_box "<color rgb='FF0000'>731</color>", :inline_format => true,size: 10, at: [445, 565]
				text_box "Date:",at: [372, 490],size:10
				text_box "For",at: [372, 400],size:10
				image "#{Rails.root}/app/assets/images/new-logo.png",scale: 0.20,at: [392, 405]
				# receipt_info(receipt)

				
 		end
	end

	def receipt_body_items(receipt)
		table receipt_body(receipt), width: 350, cell_style: { inline_format:  true } do
			columns(1).align = :right
				row(-1).height = 290
			# columns(0).width = 4
		end
	end

	def receipt_body(receipt)
		[[receipt_particulars(receipt)]]
	end

	def receipt_particulars(receipt)
		self.line_width = 1
		width = 350
		height = 470
		x, y =  0, 720
		name_width = width - 50
		stroke {
			horizontal_line x + 60, width, at: cursor - 46
			horizontal_line x , width, at: cursor - 66
			horizontal_line x + 63, width, at: cursor - 88
			horizontal_line x + 40, width, at: cursor - 115
			# horizontal_line x + 123, width - 144, at: cursor - 143
			# horizontal_line x + 235, width , at: cursor - 143
			# horizontal_line x + 50, width , at: cursor - 168
		}
		output = "<font size='10'>Received with thanks from</font>\n\n<font size='10'>Mr/Mrs/M/s. #{receipt.order.customer.name}</font>\n\n\n<font size='10'>a sum of Rs. #{receipt.amount}</font>\n\n<font size='10'>Rupees</font>"

		if receipt.payment_method == Receipt::PAYMENT_METHODS.keys.second
			output += "\n\n<font size='10'>By Cash/Cheque/Draft No.#{receipt.cheque_number}\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t dated #{receipt.cheque_date}</font>\n\n<font size='10'>Drawn On #{receipt.cheque_bank}</font>"
			stroke {
				horizontal_line x + 123, width - 144, at: cursor - 143
				horizontal_line x + 235, width , at: cursor - 143
				horizontal_line x + 50, width , at: cursor - 168
			}
		elsif [Receipt::PAYMENT_METHODS.keys.third, Receipt::PAYMENT_METHODS.keys.fourth].include? receipt.payment_method
			output += "\n\n<font size='10'>Card No. #{receipt.card_number}\t\t\ dated #{receipt.cheque_date}</font>"
			stroke {
				horizontal_line x + 200, width , at: cursor - 143
			}
		elsif receipt.payment_method == Receipt::PAYMENT_METHODS.keys.fifth
			output += "\n\n<font size='10'>UTR. #{receipt.utr} dated #{receipt.cheque_date}</font>" if receipt.utr.present?	row(-2).height = 50
		elsif receipt.payment_method == Receipt::PAYMENT_METHODS.keys.first
			output += "\n\n<font size='10'>By Cash\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t dated #{receipt.cheque_date}</font>"
			stroke {
				horizontal_line x + 123, width , at: cursor - 143
			}
		end
		output
	end





	def receipt_info(receipt)

	table receipt_side(receipt), width: 160, cell_style: { inline_format:  true } do
			# columns(1).align = :right
				row(-1).height = 286
			# columns(0).width = 4
		end
	end
	def receipt_header(receipt)
		table [["Order No :#{receipt.order.id}","Receipt No :#{receipt.id}","Date :#{receipt.created_at.strftime('%d-%m-%Y')}"]],:column_widths => {0 => 180,1 => 180,2 => 180}
	end
	
	def receipt_side(receipt)
		[[receipt_particulars1(receipt)]]
	end
	def receipt_particulars1(receipt)
		self.line_width = 1
		width = 180
		height = 400
		x, y =  180, 720
	
		output = "Received with thanks from \n\n<b>Mr/Mrs/M/s. #{receipt.order.customer.name}</b>\n\na sum of Rs. #{receipt.amount}\nRupees"
	end
end