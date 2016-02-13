module Front::ProductsHelper
	def large_decorated_frontend_price(product)
		if product.price_with_online_taxes > product.final_online_price_with_taxes
			discount_amount = product.price_with_online_taxes - product.sale_price_with_online_taxes
			discount_percent = (discount_amount*100/product.price_with_online_taxes).round
			"<span><s class='h4'>Price: #{number_to_currency product.price_with_online_taxes}</s><br/><br/><span class='h3'>Offer Price:#{number_to_currency product.sale_price_with_online_taxes} (#{discount_percent}% Off)</span></span>".html_safe
		else
			"<span class='h3'>#{number_to_currency product.price_with_online_taxes}</span>".html_safe
		end
	end
	def decorated_frontend_price(product)
		if product.price_with_online_taxes > product.final_online_price_with_taxes
			"<span><s>#{number_to_currency product.price_with_online_taxes}</s>#{number_to_currency product.sale_price_with_online_taxes}</span>".html_safe
		else
			"<span>#{number_to_currency product.price_with_online_taxes}</span>".html_safe
		end
	end
end
