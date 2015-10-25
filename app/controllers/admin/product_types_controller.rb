class Admin::ProductTypesController < Admin::ApplicationController
	def index
		@product_types = ProductType.includes(product_type_taxes: [:tax]).all
	end

	def edit
		@product_type = ProductType.find(params[:id])
	end

	def update
		@product_type = ProductType.find(params[:id])
		@product_type.update(product_type_params)
		respond_to do |format|
		  format.html { redirect_to admin_product_types_url, flash: { success: 'Product Type was successfully updated.' } }
		  format.js {}
		end
	end

	private
	  def product_type_params
	    params.require(:product_type).permit(:name, :require_workshop, product_type_taxes_attributes: [:id, :parent_id, :tax_id, :fully_taxable, :_destroy])
	  end
end
