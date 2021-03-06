class Admin::OrderItemImageCustomisationsController < Admin::ApplicationController
  load_and_authorize_resource

  def index
  end

  def edit
  end

  def update
    if @order_item_image_customisation.update(order_item_image_customisation_params.merge(user_id: current_user.id))
      redirect_to admin_workshop_index_url, flash: { success: 'Status was successfully updated.' }
    else
      render :edit
    end
  end

  private
    def order_item_image_customisation_params
      params.require(:order_item_image_customisation).permit(:status)
    end
end
