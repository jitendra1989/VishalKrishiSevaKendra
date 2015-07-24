class ProductsController < ApplicationController
  def show
  	@product = Product.find(params[:id])
  end

  def index
    @products = Product.first(8)
  end

end
