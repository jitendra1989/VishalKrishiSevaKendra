class Admin::AttributesController < Admin::ApplicationController
	load_and_authorize_resource

	def index
	end

	def new
	end

	def edit
	end

	def create
		@attribute = Attribute.new(attribute_params)
		if @attribute.save
			redirect_to admin_attributes_url, flash: { success: 'Attribute was successfully created.' }
		else
			render :new
		end
	end

	def update
		if @attribute.update(attribute_params)
			redirect_to admin_attributes_url, flash: { success: 'Attribute was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@attribute.destroy
		redirect_to admin_attributes_url, flash: { info: 'Attribute was successfully deleted.' }
	end

	private
		def attribute_params
			params.require(:attribute).permit(:name)
		end
end
