class Front::CategoriesController < Front::ApplicationController
  def show
    @category = Category.friendly.find(params[:id])
    @products = Product.online.joins(:product_categories).where(product_categories: { category_id: @category.descendant_ids << @category.id } ).distinct.page(params[:page]).per(24)
  end
end
