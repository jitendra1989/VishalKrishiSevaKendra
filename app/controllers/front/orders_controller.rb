class Front::OrdersController < Front::ApplicationController
	before_action :require_login
	def index
	end

	def new
		if session[:online_cart_id]
			@order = Order.new(customer: current_customer)
			@cart = OnlineCart.find(session[:online_cart_id])
		else
			redirect_to edit_front_cart_url
		end
	end

	def create
		if session[:online_cart_id]
			@order = OnlineOrder.new(online_cart_id: session[:online_cart_id])
			if @order.save
				session[:online_cart_id] = nil
				redirect_to success_front_order_url, flash: { success: 'Your Order was placed successfully.' }
			end
		else
			redirect_to edit_front_cart_url
		end
	end

	def success
			@order = current_customer.online_orders.last
	end


	private
		def require_login
			redirect_to login_front_customer_url unless logged_in?
		end
end
