class Front::CustomersController < Front::ApplicationController
	before_action :require_login, except: [:login, :create]
	def login
		if request.post?
			@customer = Customer.find_by(email: params[:customer][:email])
			if @customer && @customer.authenticate(params[:customer][:password])
				flash[:success] = "Welcome back, #{@customer.name}!"
				log_in @customer
			else
				flash.now[:danger] = "Invalid username or password!"
			end
		else
			@customer = Customer.new
		end
		redirect_to front_root_url if logged_in?
	end

	def logout
		log_out
		redirect_to front_root_url
	end

	def edit
	end

	def create
		@customer = Customer.new(customer_params)
		if @customer.save
			log_in @customer
			redirect_to edit_front_customer_url, flash: { success: 'Your account was successfully created.' }
		else
			render :login
		end
	end

	def update
		if @current_customer.update(customer_params)
			redirect_to edit_front_customer_url, flash: { success: 'Your account was successfully updated.'}
		else
			render :edit
		end
	end

	private
		def require_login
			redirect_to login_front_customer_url unless logged_in?
		end

		def customer_params
			params.require(:customer).permit( :name, :password, :password_confirmation, :email, :mobile, :phone, :address, :pincode, :city, :state, :country, :company_name, :company_address, :company_phone )
		end
end
