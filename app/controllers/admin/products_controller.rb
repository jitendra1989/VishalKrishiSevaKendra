class Admin::ProductsController < Admin::ApplicationController
	before_action :set_product, only: [:show, :edit, :update, :destroy]
	authorize_resource

	def index
		@products = type.constantize.all.page(params[:page]).per(20)
	end

	def edit
		@product.images.build
	end

	def new
		@product = type.constantize.new
		@product.images.build
	end

	def show
	end

	def create
		@product = type.constantize.new(product_params)
		if @product.save
			redirect_to [:admin, @product.class], flash: { success: 'Product was successfully created.' }
		else
			render :new
		end
	end

	def update
		if @product.update(product_params)
			redirect_to [:admin, @product.class], flash: { success: 'Product was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@product.destroy
		redirect_to [:admin, @product.class], flash: { info: 'Product was successfully deleted.' }
	end

	def search
		@products = Product.where('name like ? or description like ?', "%#{params[:q]}%", "%#{params[:q]}%").page(params[:page])
		render :index
	end

	def add_stock
		@product_group = ProductGroup.friendly.find(params[:id])
	end

	private
		def type
			Product.types.include?(params[:type]) ? params[:type] : 'Product'
		end

		def product_params
			params.require(type.underscore.to_sym).permit(:name, :code, :description, :product_type_id, :saleable_online, :price, :sale_price, :active, :new_quantity, :stock_code, :supplier_name, :invoice_date, :invoice_number, :stock_outlet_id, images_attributes:[:id, :name, :_destroy], product_specifications_attributes:[:id, :specification_id, :value, :_destroy], group_items_attributes:[:id, :related_product_id, :quantity, :_destroy], category_ids: [], cross_sale_product_ids: [])
		end

		def set_product
			@product = Product.friendly.find(params[:id])
		end
end
