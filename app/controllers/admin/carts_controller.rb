class Admin::CartsController < Admin::ApplicationController

	def index
		@carts = Cart.where(outlet_id: current_user.outlet_id)
	end

	def add
		@cart = Cart.find(session[:cart_id]) if session[:cart_id]
		if @cart.blank?
			@cart = Cart.create(user: current_user)
			session[:cart_id] = @cart.id
		end
		@cart.add(params[:product_id], params[:quantity])
		redirect_to view_admin_carts_url
	end

	def view
		@cart = Cart.find(session[:cart_id]) if session[:cart_id]
		redirect_to admin_carts_url unless @cart
	end
end
