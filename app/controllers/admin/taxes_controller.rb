class Admin::TaxesController < Admin::ApplicationController
  load_and_authorize_resource
  def new
    @tax = Tax.new(parent_id: params[:tax_id])
  end

  def edit
    @tax = Tax.find(params[:id])
  end

  def index
    @taxes = Tax.roots
  end

  def create
    @tax = Tax.new(tax_params.merge(parent_id: params[:tax_id]))
    if @tax.save
      redirect_to admin_taxes_url, flash: { success: 'Tax was successfully created.' }
    else
      render :new
    end
  end

  def update
    @tax = Tax.find(params[:id])
    if @tax.update(tax_params)
      redirect_to admin_taxes_url, flash: { success: 'Tax was successfully updated.' }
    else
      render :edit
    end
  end

  def destroy
    @tax = Tax.find(params[:id])
    @tax.destroy
    redirect_to admin_taxes_url, flash: { info: 'Tax was successfully deleted.' }
  end

  private
    def tax_params
      params.require(:tax).permit(:name, :percentage, :fully_taxable)
    end
end
