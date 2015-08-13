class Admin::BannersController < Admin::ApplicationController
	load_and_authorize_resource

	def index
	end

	def new
	end

	def edit
	end

	def create
		@banner = Banner.new(banner_params)
		if @banner.save
			redirect_to admin_banners_url, flash: { success: 'Banner was successfully created.' }
		else
			render :new
		end
	end

	def update
		if @banner.update(banner_params)
			redirect_to admin_banners_url, flash: { success: 'Banner was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@banner.destroy
		redirect_to admin_banners_url, flash: { info: 'Banner was successfully deleted.' }
	end

	private
		def banner_params
			params.require(:banner).permit(:name, :image, :url, category_ids: [])
		end
end
