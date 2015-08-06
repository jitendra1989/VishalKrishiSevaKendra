class Front::CategoriesController < Front::ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
  end
end
