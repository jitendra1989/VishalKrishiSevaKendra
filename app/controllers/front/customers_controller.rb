class Front::CustomersController < Front::ApplicationController
	def login
		if request.post?
			@customer = Customer.find_by(email: params[:customer][:email])
			if @customer && @customer.authenticate(params[:customer][:password])
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
		@customer = Customer.find(params[:id])
	end
end
