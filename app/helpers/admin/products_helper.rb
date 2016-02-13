module Admin::ProductsHelper
	def large_decorated_price(product)
		if product.price_with_taxes > product.final_price_with_taxes
			discount_amount = product.price_with_taxes - product.sale_price_with_taxes
			discount_percent = (discount_amount*100/product.price_with_taxes).round
			"<span><s class='actual-price'>Price: #{number_to_currency product.price_with_taxes}</s> <span class='offer-price'>#{number_to_currency product.sale_price_with_taxes} (#{discount_percent}% Off)</span></span>".html_safe
		else
			"<span class='h3'>#{number_to_currency product.price_with_taxes}</span>".html_safe
		end
	end
	def decorated_price(product)
		if product.price_with_taxes > product.final_price_with_taxes
			discount_amount = product.price_with_taxes - product.sale_price_with_taxes
			discount_percent = (discount_amount*100/product.price_with_taxes).round
			"<span><s>#{number_to_currency product.price_with_taxes}</s>#{number_to_currency product.sale_price_with_taxes}</span><span class='discount-percent'>-#{discount_percent}%</span>".html_safe
		else
			"<span>#{number_to_currency product.price_with_taxes}</span>".html_safe
		end
	end
end
