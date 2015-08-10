module Front::ProductsHelper
	def decorated_frontend_price(product)
		if product.price_with_online_taxes > product.online_price
			"<span><s>#{number_to_currency product.price_with_online_taxes}</s>#{number_to_currency product.sale_price_with_online_taxes}</span>".html_safe
		else
			"<span>#{number_to_currency product.price_with_online_taxes}</span>".html_safe
		end
	end
end
