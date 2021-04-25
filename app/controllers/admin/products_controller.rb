class Admin::ProductsController < Admin::ApplicationController
	before_action :set_product, only: [:show, :update, :destroy]
	authorize_resource

	def index
		@products = object_type.constantize.mass_produced.all.page(params[:page]).per(20)
	end

	def edit
		if params[:step] == 'image_specifications'
			@product = Product.includes(product_characteristics: [:characteristic_image, :characteristic]).friendly.find(params[:id])
		else
			@product = Product.friendly.find(params[:id])
		end
		@product.current_step = params[:step] if params[:step]
	end

	def new
		@product = object_type.constantize.new
	end

	def show
	end

	def create
		@product = object_type.constantize.new(product_params)
		if @product.save
			product_redirect('Product was successfully created.')
		else
			render :new
		end
	end

	def update
		@product = Product.last
		if @product.update(product_params)
			product_redirect('Product was successfully updated.')
		else
			render :edit
		end
	end

	def destroy
		@product.destroy
		redirect_to (request.referrer || [:admin, @product.class]), flash: { info: 'Product was successfully deleted.' }
	end

	def search
		@products = Product.mass_produced.where('name like ? or description like ?', "%#{params[:q]}%", "%#{params[:q]}%").page(params[:page])
		render :index
	end

	def add_stock
		@product_group = ProductGroup.friendly.find(params[:id])
	end

	private
		def object_type
			Product.types.include?(params[:type]) ? params[:type] : 'Product'
		end

		def product_params
			params.require(object_type.underscore.to_sym).permit(:current_step, :name, :code, :description, :product_type_id, :saleable_online, :customised, :requirement_id, :price, :sale_price, :active, :new_quantity, :stock_code, :supplier_name, :invoice_date, :invoice_number, :stock_outlet_id, images_attributes:[:id, :name, :_destroy], product_specifications_attributes:[:id, :specification_id, :value, :_destroy], product_characteristics_attributes:[:id, :characteristic_id, :characteristic_image_id, :_destroy], group_items_attributes:[:id, :related_product_id, :quantity, :_destroy], category_ids: [], cross_sale_product_ids: [], coupon_code_ids: [])
		end

		def set_product
			@product = Product.friendly.find(params[:id])
		end

		def product_redirect(flash)
			if @product.requirement_id.blank?
				if params[:go_to] == 'back'
					@product.previous_step
				elsif params[:go_to] == 'next'
					@product.next_step
				end
				redirect_to edit_admin_product_url(@product, @product.current_step), flash: { success: flash }
			else
				redirect_to add_product_admin_requirement_url(@product.requirement_id, @product.id), flash: { success: flash }
			end
		end
end
