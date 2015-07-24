class Admin::QuotationsController < Admin::ApplicationController
	def index
		@quotations = Quotation.includes(:customer).all
	end

	def show
		@quotation = Quotation.find(params[:id])
		respond_to do |format|
			format.html
			format.pdf do
				pdf = QuotationPdf.new(@quotation)
				send_data pdf.render, filename: "quotation_#{@quotation.id}.pdf", disposition: "inline"
			end
		end
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

	def products
		@products = Product.where('name like ?', "%#{params[:q]}%")
		render formats: :json
	end

	private
		def quotation_params
			params.require(:quotation).permit(:discount_amount, products_attributes: [:product_id, :quantity])
		end
end
