class Front::CustomersController < Front::ApplicationController
	before_action :require_activation, except: [:login, :create, :activate]
	def login
		if request.post?
			@customer = Customer.find_by(email: params[:customer][:email])
			if @customer && @customer.authenticate(params[:customer][:password])
				if @customer.activated?
					flash[:success] = "Welcome back, #{@customer.name}!"
					log_in @customer
				else
					require_activation
				end
			else
				flash.now[:danger] = "Invalid username or password!"
			end
		end
		@customer = Customer.new unless @customer
		customer_redirect if logged_in?
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
			redirect_to login_front_customer_url, flash: { success: 'Thank you for registering, please check your email for an activation link.' }
		else
			render :login
		end
	end

	def update
		respond_to do |format|
			if @current_customer.update(customer_params)
				flash[:success] = 'Your account was successfully updated.'
				format.html { customer_redirect }
				format.js do
					flash.now[:success] = 'Your password was updated.'
					render :edit
				end
			else
				format.html { render :edit }
				format.js { render :edit }
			end
		end
	end

	def activate
		customer = Customer.find_by(activation_digest: params[:token])
		if customer
			activate_and_login customer
		else
			redirect_to login_front_customer_url, flash: { danger: 'We are sorry, we encountered a problem activating your account. Please try again.' }
		end
	end

	private
		def customer_params
			params.require(:customer).permit( :name, :password, :password_confirmation, :email, :mobile, :phone, :address, :pincode, :city, :state, :country, :company_name, :company_address, :company_phone )
		end

		def activate_and_login(customer)
			customer.activate
			log_in customer
			redirect_to edit_front_customer_url, flash: { success:  'Your account has been activated. Welcome to Damian De Goa.' }
		end
		def customer_redirect
			if @current_customer.online_cart.try(:items).try(:size)
				redirect_to edit_front_cart_url
			else
				redirect_to front_root_url
			end
		end
end
