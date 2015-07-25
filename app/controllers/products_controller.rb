class ProductsController < ApplicationController
	def show
		@product = Product.friendly.find(params[:id])
	end

	def index
		@products = Product.includes(:product_type).first(8)
	end

end
