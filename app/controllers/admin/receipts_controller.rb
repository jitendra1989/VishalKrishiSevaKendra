class Admin::ReceiptsController < Admin::ApplicationController
	before_action :set_order, only: [:new, :index, :create]
	def new
		@receipt = @order.receipts.build
	end

	def index
		@receipts = @order.receipts
	end

	def show
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
			params.require(:receipt).permit(:code, :amount, :payment_method, :cheque_number, :cheque_date, :cheque_bank, :card_number)
		end

		def set_order
			@order = Order.find(params[:order_id])
		end
end
