class Admin::OrderItemCustomisationsController < Admin::ApplicationController
	load_and_authorize_resource

  def index
  end

  def edit
  end

  def update
    if @order_item_customisation.update(order_item_customisation_params.merge(user_id: current_user.id))
      redirect_to admin_order_item_customisations_url, flash: { success: 'Status was successfully updated.' }
    else
      render :edit
    end
  end

  private
    def order_item_customisation_params
      params.require(:order_item_customisation).permit(:status)
    end
end
