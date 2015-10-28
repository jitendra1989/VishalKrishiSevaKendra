class Admin::SpecificationsController < Admin::ApplicationController
	load_and_authorize_resource

	def index
		@specifications = Specification.all.page(params[:page])
	end

	def new
	end

	def edit
	end

	def create
		@specification = Specification.new(specification_params)
		if @specification.save
			redirect_to admin_specifications_url, flash: { success: 'Specification was successfully created.' }
		else
			render :new
		end
	end

	def update
		if @specification.update(specification_params)
			redirect_to admin_specifications_url, flash: { success: 'Specification was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@specification.destroy
		redirect_to admin_specifications_url, flash: { info: 'Specification was successfully deleted.' }
	end

	private
		def specification_params
			params.require(:specification).permit(:name, :required, :units)
		end
end
