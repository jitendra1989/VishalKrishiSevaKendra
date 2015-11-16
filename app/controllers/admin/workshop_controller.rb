class Admin::WorkshopController < Admin::ApplicationController
  def index
    @order_items = OrderItem.includes(:product, image_customisations: [:characteristic, :characteristic_image], customisations: [:specification]).where('customisations_count != 0 OR image_customisations_count != 0').order('order_id DESC')
  end
end
