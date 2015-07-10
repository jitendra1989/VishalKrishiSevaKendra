class Admin::ProductsController < Admin::ApplicationController
	before_action :set_product, only: [:edit, :update, :destroy, :show]

  def index
  	@products = Product.all
  end

  def edit
  end

  def new
  	@product = Product.new
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
  	# Use callbacks to share common setup or constraints between actions.
  	def set_product
  		@product = Product.find(params[:id])
  	end

  	# Never trust parameters from the scary internet, only allow the white list through.
  	def product_params
  		params.require(:product).permit(:name, :code, :description, :price, :active)
  	end
end
