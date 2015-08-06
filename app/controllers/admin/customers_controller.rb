class Admin::CustomersController < Admin::ApplicationController
	load_and_authorize_resource
	def edit
		@customer = Customer.find(params[:id])
	end

	def index
		@customers = Customer.all.page(params[:page])

	end

	def new
		@customer = Customer.new
	end

	def search
		@customers = Customer.where('name like ? or mobile like ? or email like ?', "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%").page(params[:page])
		render :index
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			customer_redirect success: 'Customer was successfully created.'
		else
			render :new
		end
	end

	def update
		@customer = Customer.find(params[:id])
		if @customer.update(customer_params)
			customer_redirect success: 'Customer was successfully updated.'
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
			params.require(:customer).permit( :name, :password, :password_confirmation, :email, :mobile, :phone, :address, :pincode, :city, :state, :country, :company_name, :company_address, :company_phone )
		end

		def customer_redirect(flash)
			if params[:next] == 'cart'
				redirect_url = edit_admin_cart_url(@customer.activate_cart(current_user))
			elsif params[:next] == 'quotation'
				redirect_url = new_admin_customer_quotation_url(@customer)
			else
				redirect_url = admin_customers_url
			end
			redirect_to redirect_url, flash: flash
		end
end
