class Front::ProductsController < Front::ApplicationController
	def show
		@product = Product.online.friendly.find(params[:id])
	end

	def index
		@banners = Banner.all
		@products = Product.online.first(8)
	end

end
