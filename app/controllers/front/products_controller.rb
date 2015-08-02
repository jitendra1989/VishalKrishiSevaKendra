class Front::ProductsController < Front::ApplicationController
	def show
		@product = Product.online.friendly.find(params[:id])
	end

	def index
		@products = Product.online.first(8)
	end

end
