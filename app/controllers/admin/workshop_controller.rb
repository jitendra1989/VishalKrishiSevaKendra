class Admin::WorkshopController < Admin::ApplicationController
  def index
  	@order_item_image_customisations = OrderItemImageCustomisation.all.limit(5)
  	@order_item_customisations = OrderItemCustomisation.all.limit(5)
  end
end
