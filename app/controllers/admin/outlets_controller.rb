class Admin::OutletsController < Admin::ApplicationController
	before_action :set_outlet, only: [:edit, :update, :destroy]
	load_and_authorize_resource

	def index
		@outlets = Outlet.all
	end

	def new
		@outlet = Outlet.new
	end

	def edit
	end

	def create
		@outlet = Outlet.new(outlet_params)
		if @outlet.save
			redirect_to admin_outlets_url, flash: { success: 'Outlet was successfully created.' }
		else
			render :new
		end
	end

	def update
		if @outlet.update(outlet_params)
			redirect_to admin_outlets_url, flash: { success: 'Outlet was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@outlet.destroy
		redirect_to admin_outlets_url, flash: { info: 'Outlet was successfully deleted.' }
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_outlet
			@outlet = Outlet.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def outlet_params
			params.require(:outlet).permit(:name, :country, :state, :city)
		end
end
