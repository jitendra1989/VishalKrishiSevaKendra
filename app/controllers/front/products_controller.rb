class Front::ProductsController < Front::ApplicationController
	def show
		@product = Product.online.friendly.find(params[:id])
	end

	def index
		@banners = Banner.all
		@products = Product.online.page(params[:page]).per(24)
	end

	def search
		@products = Product.online.where("name LIKE ? OR description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").page(params[:page]).per(24)
		redirect_to front_root_url, flash: { info: 'No Products found matching your query. Please try searching for something else.'} unless @products.size > 0
	end

end
