class Admin::CharacteristicsController < Admin::ApplicationController
	load_and_authorize_resource

	def index
		@characteristics = Characteristic.all.page(params[:page])
	end

	def new
		@characteristic.images.build
	end

	def edit
		@characteristic.images.build
	end

	def images
		render layout: false
	end

	def create
		@characteristic = Characteristic.new(characteristic_params)
		if @characteristic.save
			redirect_to admin_characteristics_url, flash: { success: 'Image specification was successfully created.' }
		else
			render :new
		end
	end

	def update
		if @characteristic.update(characteristic_params)
			redirect_to admin_characteristics_url, flash: { success: 'Image specification was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@characteristic.destroy
		redirect_to admin_characteristics_url, flash: { info: 'Image specification was successfully deleted.' }
	end

	private
		def characteristic_params
			params.require(:characteristic).permit(:name, images_attributes: [:id, :name, :code, :_destroy])
		end
end
