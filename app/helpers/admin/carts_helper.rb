module Admin::CartsHelper
	def cart_count
		session[:cart_id] ? Cart.find(session[:cart_id]).items.count : 0
	end
	def active_cart_url
		session[:cart_id] ? edit_admin_cart_path(session[:cart_id]) : admin_carts_path
	end
end