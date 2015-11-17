class Admin::WorkshopController < Admin::ApplicationController
  def index
    @order_items = OrderItem.includes(:product, image_customisations: [:characteristic, :characteristic_image], customisations: [:specification]).where('customisations_count != 0 OR image_customisations_count != 0').order('order_id DESC')
  end

  def assign
    authorize! :workshop, :assign
    if params[:customisation] == 'customisation'
      @order_item_customisation = OrderItemCustomisation.find(params[:id])
      @order_item_customisation.assign(params[:user_id], current_user.id)
    else
      @order_item_image_customisation = OrderItemImageCustomisation.find(params[:id])
      @order_item_image_customisation.assign(params[:user_id], current_user.id)
    end
    redirect_to admin_workshop_index_url, flash: { success: 'Assignment was successful.' }
  end
end
