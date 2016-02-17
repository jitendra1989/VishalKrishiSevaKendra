class Admin::ReceiptsController < Admin::ApplicationController
	before_action :set_order, only: [:new, :create]
	def new
		@receipt = @order.receipts.build
	end

	def index
		if params[:order_id]
			@order = Order.find(params[:order_id])
			@receipts = @order.receipts.page(params[:page])
		else
			@receipts = Receipt.includes(:order).all.page(params[:page])
		end
	end

	def show
		@receipt = Receipt.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
				pdf = ReceiptPdf.new(@receipt)
				send_data pdf.render, filename: "receipt_#{@receipt.id}.pdf", disposition: "inline"
			end
		end
	end

	def create
		@receipt = @order.receipts.new(receipt_params.merge(user: current_user))
		if @receipt.save
			redirect_to admin_orders_url, success: 'Receipt was successfully created.'
		else
			render :new
		end
	end

	private
		def receipt_params
			params.require(:receipt).permit(:code, :amount, :payment_method, :cheque_number, :cheque_date, :cheque_bank, :card_number, :utr)
		end

		def set_order
			@order = Order.find(params[:order_id]) if params[:order_id]
		end
end
