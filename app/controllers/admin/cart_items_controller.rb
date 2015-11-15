class Admin::CartItemsController < Admin::ApplicationController
  before_action :set_cart_item, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def update
    if @cart_item.update(cart_item_params)
      redirect_to edit_admin_cart_item_url(@cart_item), flash: { success: 'Cart item was successfully updated.' }
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
      @cart = @cart_item.cart
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_item_params
      params.require(:cart_item).permit(customisations_attributes: [:id, :specification_id, :value, :_destroy])
    end
end
