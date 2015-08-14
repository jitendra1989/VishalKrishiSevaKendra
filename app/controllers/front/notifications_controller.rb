class Front::NotificationsController < Front::ApplicationController
	before_action :require_validation
	def create
		StockNotification.find_or_create_by(customer: current_customer, product_id: params[:product_id])
		redirect_to front_product_url(params[:product_id]), flash: { success: 'You will be notified when we have this item in stock.'}
	end
end
