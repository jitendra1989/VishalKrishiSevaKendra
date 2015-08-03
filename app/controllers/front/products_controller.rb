class Front::ProductsController < Front::ApplicationController
	def show
		@product = Product.online.friendly.find(params[:id])
	end

	def index
		@banners = Banner.all
		@products = Product.online.first(8)
	end

	def search
		@products = Product.online.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
		redirect_to front_root_url, flash: { info: 'No Products found matching your query. Please try searching for something else.'} unless @products.size > 0
	end

end
