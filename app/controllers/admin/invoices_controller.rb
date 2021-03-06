class Admin::InvoicesController < Admin::ApplicationController
  def index
    @invoices = Invoice.includes(:customer).all.order('created_at DESC').page(params[:page])
  end

  def new
    @customer = Customer.find(params[:customer_id])
    @invoice = @customer.invoices.build
  end

  def show
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context)
        send_data pdf.render, filename: "invoice_#{@invoice.id}.pdf", disposition: "inline"
      end
    end
  end

  def gatepass
    @invoice = Invoice.find(params[:id])
    pdf = GatePassPdf.new(@invoice, view_context)
    send_data pdf.render, filename: "gatepass_#{@invoice.id}.pdf", disposition: "inline"
  end

  def dc
    @invoice = Invoice.find(params[:id])
    pdf = DcPdf.new(@invoice, view_context)
    send_data pdf.render, filename: "dc_#{@invoice.id}.pdf", disposition: "inline"
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
