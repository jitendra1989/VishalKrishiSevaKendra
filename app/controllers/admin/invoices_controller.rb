class Admin::InvoicesController < Admin::ApplicationController
  def index
  end

  def new
  	@customer = Customer.find(params[:customer_id])
  	@invoice = @customer.invoices.build
  end
end
