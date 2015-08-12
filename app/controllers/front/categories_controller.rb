class Front::CategoriesController < Front::ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @products = @category.products.online.page(params[:page]).per(24)
  end
end
