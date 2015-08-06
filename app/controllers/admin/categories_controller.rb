class Admin::CategoriesController < Admin::ApplicationController
	before_action :set_category, only: [:edit, :update, :destroy]
	authorize_resource

	def new
		@category = Category.new(parent_id: params[:category_id])
	end

	def edit
	end

	def index
		@categories = Category.roots
	end

	def create
		respond_to do |format|
			@category = Category.new(category_params.merge(parent_id: params[:category_id]))
			if @category.save
				format.html { redirect_to admin_categories_url, flash: { success: 'Category was successfully created.' } }
				format.js
			else
				format.html { render :new }
				format.js { render :new }
			end
		end
	end

	def update
		respond_to do |format|
			if @category.update(category_params)
				format.html { redirect_to admin_categories_url, flash: { success: 'Category was successfully updated.' } }
				format.js
			else
				format.html { render :edit }
				format.js { render :edit }
			end
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

		def set_category
			@category = Category.friendly.find(params[:id])
		end
end
