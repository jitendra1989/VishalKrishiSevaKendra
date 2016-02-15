class Admin::CartsController < Admin::ApplicationController
	before_action :set_cart, only: [:edit, :update, :remove, :destroy]
	load_and_authorize_resource

	def index
		@carts = Cart.includes(:customer, :user).where(outlet: current_user.outlet)
	end

	def add
		@cart = Cart.find_by(id: session[:cart_id]) if session[:cart_id]
		find_or_create_cart unless @cart
		@cart.add_item(params[:product_id], params[:quantity])
		redirect_to edit_admin_cart_url(@cart), flash: { success: 'Item successfully added to cart.' }
	end

	def create
		find_or_create_cart
		redirect_to edit_admin_cart_url(@cart), flash: { success: 'Cart was successfully created.' }
	end

	def update
		@cart.update_item(params[:product_id], params[:quantity])
		redirect_to edit_admin_cart_url(@cart), flash: { success: 'Your cart was successfully updated.' }
	end

	def edit
		session[:cart_id] = @cart.id
		@order = current_user.orders.build(outlet: current_user.outlet)
	end

	def assign
		redirect_to edit_admin_cart_url(Customer.find(params[:customer_id]).activate_cart(current_user))
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

		def find_or_create_cart
			@cart = Cart.find_or_create_by(user: current_user, outlet: current_user.outlet, customer: nil)
			session[:cart_id] = @cart.id
		end
end
