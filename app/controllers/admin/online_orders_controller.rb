class Admin::OnlineOrdersController < Admin::ApplicationController
	authorize_resource :online_order, parent: false

	def index
		@online_orders = OnlineOrder.includes(:customer).all
	end

	def show
		@online_order = OnlineOrder.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
				pdf = OnlineOrderPdf.new(@online_order, view_context)
				send_data pdf.render, filename: "order_#{@online_order.id}.pdf", disposition: "inline"
			end
		end
	end
	def invoice
		@online_order = OnlineOrder.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
				pdf = OnlineOrderInvoicePdf.new(@online_order, view_context)
				send_data pdf.render, filename: "order_invoice_#{@online_order.id}.pdf", disposition: "inline"
			end
		end
	end
end
