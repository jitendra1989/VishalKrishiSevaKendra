class Admin::ReceiptsController < Admin::ApplicationController
  def new
  	@order = Order.find(params[:order_id])
  	@receipt = @order.receipts.build
  end

  def show
  end
end
