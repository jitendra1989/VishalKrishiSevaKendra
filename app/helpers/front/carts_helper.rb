module Front::CartsHelper
	def online_cart_count
		OnlineCart.find_by(id: session[:online_cart_id]).try(:items).try(:count) || 0
	end
end
