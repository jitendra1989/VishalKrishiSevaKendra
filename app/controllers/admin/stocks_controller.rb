class Admin::StocksController < Admin::ApplicationController
  before_action :set_product, only: [:new, :index, :create]
  load_and_authorize_resource :product
  load_and_authorize_resource :stock, through: :product, shallow: true

  def new
    @stock = @product.stocks.build
  end

  def index
    @stocks = @product.stocks.where(outlet: current_user.outlet)
  end

  def create
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

    def set_product
      @product = Product.friendly.find(params[:product_id])
    end
end
