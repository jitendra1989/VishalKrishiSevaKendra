class Admin::OrdersController < Admin::ApplicationController
	load_and_authorize_resource

	def index
		@orders = Order.includes(:customer).where(outlet: current_user.outlet).order('created_at DESC').page(params[:page])
	end

	def create
		@cart = Cart.find_by(id: session[:cart_id])
		if @cart.try(:items).try(:present?)
			if session[:cart_id]
				@order = Order.new(order_params.merge(user: current_user, outlet: current_user.outlet, cart_id: session[:cart_id]))
				if @order.save
					session[:cart_id] = nil
					redirect_to admin_orders_url, flash: { success: 'Order was successfully created.' }
				else
					render template: 'admin/carts/edit'
				end
			else
				redirect_to admin_carts_url
			end
		else
			redirect_to admin_carts_url, flash: { warning: 'Please add some items to the cart first.' }
		end
	end

	def show
		@order = Order.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
				pdf = OrderPdf.new(@order, view_context)
				send_data pdf.render, filename: "order_#{@order.id}.pdf", disposition: "inline"
			end
		end
	end

	def edit
	end

	def flag
		@order.update(overridden: true, flagged_by: current_user.id, comment: params[:comment])
		redirect_to admin_orders_url, flash: { success: 'Order was successfully flagged.' }
	end

	private
		def order_params
			params.require(:order).permit(:discount_amount)
		end
end
