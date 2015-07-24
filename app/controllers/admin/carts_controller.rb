class Admin::CartsController < Admin::ApplicationController
	before_action :set_cart, only: [:add, :view]

	def index
		@carts = Cart.where(outlet: current_user.outlet)
	end

	def add
		if @cart.blank?
			@cart = Cart.create(user: current_user, outlet: current_user.outlet)
			session[:cart_id] = @cart.id
		end
		@cart.add(params[:product_id], params[:quantity])
		redirect_to view_admin_carts_url
	end

	def view
		redirect_to admin_carts_url unless @cart
	end

	private
		def set_cart
			@cart = Cart.find(session[:cart_id]) if session[:cart_id]
		end
end
