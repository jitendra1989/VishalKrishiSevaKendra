class Front::OrdersController < Front::ApplicationController
	before_action :require_validation
	skip_before_action :clear_blocked_stock, only: [:new, :payment, :create]
	def index
	end

	def new
		if session[:online_cart_id]
			@order = OnlineOrder.new(customer: current_customer)
			@cart = OnlineCart.find(session[:online_cart_id])
			session[:blocked_stock_jid] = @cart.check_and_block_stock unless session[:blocked_stock_jid]
		else
			redirect_to edit_front_cart_url
		end
	end

	def create
		if session[:online_cart_id]
			@order = OnlineOrder.new(customer: current_customer, online_cart_id: session[:online_cart_id])
			if @order.save
				successful_order_cleanup
				redirect_to success_front_order_url, flash: { success: 'Your Order was placed successfully.' }
			end
		else
			redirect_to edit_front_cart_url
		end
	end

	def success
		@order = current_customer.online_orders.last
	end

	def payment
		if session[:online_cart_id] && params[:DR]
			@order = OnlineOrder.new(customer: current_customer, online_cart_id: session[:online_cart_id])
			if @order.process_payment_and_place_order(params[:DR])
				successful_order_cleanup
				flash[:success] = 'Your Order was placed successfully.'
			end
			redirect_to success_front_order_url
		else
			flash[:danger] = 'There was a problem processing your order, please try again.'
			render :new
		end
	end

	private
		def successful_order_cleanup
			session[:online_cart_id] = nil
			if session[:blocked_stock_jid]
				scheduled_set = Sidekiq::ScheduledSet.new
				jobs = scheduled_set.select {|job| job.jid == session[:blocked_stock_jid] }
				jobs.each(&:delete)
				session[:blocked_stock_jid] = nil
			end
		end
end
