class Admin::ProductsController < Admin::ApplicationController
	load_and_authorize_resource

	def index
		@products = Product.includes(:product_type).all.page(params[:page]).per(20)
	end

	def edit
		@product.images.build
	end

	def new
		@product = Product.new
		@product.images.build
	end

	def show
	end

	def create
		@product = Product.new(product_params)
		if @product.save
			redirect_to admin_products_url, flash: { success: 'Product was successfully created.' }
		else
			render :new
		end
	end

	def update
		if @product.update(product_params)
			redirect_to admin_products_url, flash: { success: 'Product was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@product.destroy
		redirect_to admin_products_url, flash: { info: 'Product was successfully deleted.' }
	end

	private
		def product_params
			params.require(:product).permit(:name, :code, :description, :product_type_id, :price, :active, images_attributes:[:id, :name, :_destroy], category_ids: [])
		end
end
