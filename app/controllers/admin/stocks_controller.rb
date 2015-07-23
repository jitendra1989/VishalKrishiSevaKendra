class Admin::StocksController < Admin::ApplicationController
  def new
    @product = Product.find(params[:product_id])
    @stock = @product.stocks.build
  end

  def index
    @product = Product.find(params[:product_id])
    @stocks = @product.stocks.where(outlet: current_user.outlet)
  end

  def create
    @product = Product.find(params[:product_id])
    @stock = @product.stocks.build(stock_params.merge(outlet: current_user.outlet))
    if @stock.save
      redirect_to admin_product_stocks_url(@product), flash: { success: 'Stock was successfully created.' }
    else
      render :new
    end
  end

  private
    def stock_params
      params.require(:stock).permit(:new_quantity, :code)
    end
end
