class Front::CategoriesController < Front::ApplicationController
  def show
  	@category = Category.find(params[:id])
  end
end
