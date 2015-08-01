class ReceiptPdf < Prawn::Document
	def initialize(receipt)
		super(top_margin: 40)
		pad(10){ text"Receipt Voucher", align: :center,size: 18 }
		move_down 10
		receipt_header(receipt)
		move_down 30
		receipt_body_items(receipt)
		stroke_horizontal_rule
		move_down 10
		move_down 10
		move_down 10
		text_box "for Damian de Goa", style: :bold, at: [420, 420]
		text_box "Authorized Signatory", at: [420, 380]
	end
	def receipt_header(receipt)
		table [["Order No :#{receipt.order.id}","Receipt No :#{receipt.id}","Date :#{receipt.order.customer.created_at.strftime('%d-%m-%Y')}"]],:column_widths => {0 => 180,1 => 180,2 => 180}
	end
	def receipt_body_items(receipt)
		table receipt_body(receipt), width: 540, cell_style: { inline_format:  true } do
			columns(1).align = :right
			columns(0).width = 450
		end
	end
	def receipt_body(receipt)
		[["Particulars", "Amount"],[receipt_particulars(receipt),"#{receipt.amount}" ],["Total","#{receipt.amount}" ],["Amount in words: #{receipt.amount_in_words}", '']]
	end
	def receipt_particulars(receipt)
		output = "Received with thanks from :\n\n<b>#{receipt.order.customer.name}</b>\n#{receipt.order.customer.full_address}\n\nPayment Through : #{Receipt::PAYMENT_METHODS[receipt.payment_method]}"
		if receipt.payment_method == Receipt::PAYMENT_METHODS.keys.second
			output += "\nCheque No. #{receipt.cheque_number} Date #{receipt.cheque_date} Drawn On #{receipt.cheque_bank}"
		elsif receipt.payment_method == Receipt::PAYMENT_METHODS.keys.third
			output += "\nCard No. #{receipt.card_number}"
		end
		output
	end

end
