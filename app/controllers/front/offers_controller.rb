class Front::OffersController < Front::ApplicationController
  def show
    @banner = Banner.find(params[:id])
    @products = Product.online.joins(:product_categories).where(product_categories: { category_id: @banner.category_ids } ).distinct.page(1).per(24)
  end
end
