class Admin::OrdersController < Admin::ApplicationController
	load_and_authorize_resource

	def index
		@orders = Order.includes(:customer).where(outlet: current_user.outlet)
	end

	def create
		if session[:cart_id]
			@order = Order.new(order_params.merge(user: current_user, outlet: current_user.outlet, cart_id: session[:cart_id]))
			if @order.save
				session[:cart_id] = nil
				redirect_to admin_orders_url, flash: { success: 'Order was successfully created.' }
			end
		else
			redirect_to admin_carts_url
		end
	end

	def show
		@order = Order.find(params[:id])
	end

	def edit
	end

	private
		def order_params
			params.require(:order).permit(:discount_amount)
		end
end
