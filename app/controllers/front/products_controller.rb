class Front::ProductsController < Front::ApplicationController
	def show
		@product = Product.friendly.find(params[:id])
	end

	def index
		@products = Product.first(8)
	end

end
