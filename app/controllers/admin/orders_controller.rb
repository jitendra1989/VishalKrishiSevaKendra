class Admin::OrdersController < Admin::ApplicationController

	def index
		@orders = Order.where(outlet: current_user.outlet)
	end

	def create
		if session[:cart_id]
			@order = Order.new(order_params.merge(user: current_user, outlet: current_user.outlet, cart_id: session[:cart_id]))
			if @order.save
				redirect_to admin_orders_url, flash: { success: 'Order was successfully created.' }
			else
				render :edit
			end
		else
			redirect_to admin_carts_url
		end
	end

	def show
	end

	def edit
	end

	private
		def order_params
			params.require(:order).permit(:discount_amount)
		end
end