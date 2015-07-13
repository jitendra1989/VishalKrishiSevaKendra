class Admin::CustomersController < Admin::ApplicationController
	def edit
		@customer = Customer.find(params[:id])
	end

	def index
		@customers = Customer.all

	end

	def new
		@customer = Customer.new
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			redirect_to admin_customers_url, flash: { success: 'Customer was successfully created.' }
		else
			render :new
		end
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update(customer_params)
			redirect_to admin_customers_url, flash: { success: 'Customer was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@customer = Customer.find(params[:id])
		@customer.destroy
		redirect_to admin_customers_url, flash: { info: 'Customer was successfully deleted.' }
	end

	private
		def customer_params
			params.require(:customer).permit( :name, :email, :mobile, :phone, :address, :pincode, :city, :state, :country, :company_name, :company_address, :company_phone )
		end
end
