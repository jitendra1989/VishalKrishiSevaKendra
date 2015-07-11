class Admin::CategoriesController < Admin::ApplicationController
	load_and_authorize_resource

	def new
		@category = Category.new
	end

	def edit
	end

	def index
		@categories = Category.roots
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			redirect_to admin_categories_url, flash: { success: 'Category was successfully created.' }
		else
			render :new
		end
	end

	def update
		if @category.update(category_params)
			redirect_to admin_categories_url, flash: { success: 'Category was successfully updated.' }
		else
			render :edit
		end
	end

	def destroy
		@category.destroy
		redirect_to admin_categories_url, flash: { info: 'Category was successfully deleted.' }
	end

	private
		def category_params
			params.require(:category).permit(:name)
		end
end
