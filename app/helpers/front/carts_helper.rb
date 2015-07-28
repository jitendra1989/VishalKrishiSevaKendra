module Front::CartsHelper
	def online_cart_count
		session[:online_cart_id] ? OnlineCart.find(session[:online_cart_id]).items.count : 0
	end
end
