class Admin::ReportsController < Admin::ApplicationController
	def stock
		if params[:category_id]
			@category = Category.find_by(id: params[:category_id])
			@stocks = Stock.includes(product: [:product_type]).where(id: @category.products.ids, created_at: params[:from_date].to_time.beginning_of_day..params[:to_date].to_time.beginning_of_day) if @category
		end
	end

	def workshop
		@workshop_log = WorkshopLog.all.order('created_at DESC')
		@workshop_image_log = WorkshopImageLog.all.order('created_at DESC')
	end
end
