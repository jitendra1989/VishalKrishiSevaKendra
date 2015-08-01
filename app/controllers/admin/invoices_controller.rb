class Admin::InvoicesController < Admin::ApplicationController
  def index
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.build
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.build(invoice_params)
    if @invoice.save
      redirect_to admin_invoices_url, flash: { success: 'Invoice was successfully created.' }
    else
      render :new
    end
  end

  private
    def invoice_params
      params.require(:invoice).permit(order_ids: [])
    end

end
