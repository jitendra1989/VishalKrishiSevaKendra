module Admin::CartsHelper
	def cart_count
		Cart.find_by(id: session[:cart_id]).try(:items).try(:count) || 0
	end
	def active_cart_url
		session[:cart_id] ? edit_admin_cart_path(session[:cart_id]) : admin_carts_path
	end
end