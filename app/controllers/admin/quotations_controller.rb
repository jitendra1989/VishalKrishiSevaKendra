class Admin::QuotationsController < Admin::ApplicationController
	def index
		@quotations = Quotation.all
	end

	def show
		@quotation = Quotation.find(params[:id])
	end

	def new
		@customer = Customer.find(params[:customer_id])
		@quotation = @customer.quotations.build
	end

	def create
		@customer = Customer.find(params[:customer_id])
		@quotation = @customer.quotations.new(quotation_params.merge(user: current_user))
		if @quotation.save
			redirect_to admin_quotations_url, flash: { success: 'Quotation was successfully created.' }
		else
			render :new
		end
	end

	private
		def quotation_params
			params.require(:quotation).permit(:discount_amount, products_attributes: [:product_id, :quantity])
		end
end
