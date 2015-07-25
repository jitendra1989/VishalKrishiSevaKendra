class Admin::CartsController < Admin::ApplicationController
	before_action :set_cart, only: [:edit, :update, :remove, :destroy]

	def index
		@carts = Cart.where(outlet: current_user.outlet)
	end

	def add
		@cart = Cart.find(session[:cart_id]) if session[:cart_id]
		unless @cart
			@cart = Cart.find_or_create_by(user: current_user, outlet: current_user.outlet, customer: nil)
			session[:cart_id] = @cart.id
		end
		@cart.add_item(params[:product_id], params[:quantity])
		redirect_to edit_admin_cart_url(@cart), flash: { success: 'Item successfully added to cart.' }
	end

	def update
		@cart.update_item(params[:product_id], params[:quantity])
		redirect_to edit_admin_cart_url(@cart), flash: { success: 'Your cart was successfully updated.' }
	end

	def edit
	end

	def remove
		@cart.destroy_item(params[:product_id])
		redirect_to edit_admin_cart_url(@cart)
	end

	def destroy
		@cart.destroy
		redirect_to admin_carts_url, flash: { info: 'Cart was successfully deleted.' }
	end

	private
		def set_cart
			@cart = Cart.find(params[:id])
		end
end
