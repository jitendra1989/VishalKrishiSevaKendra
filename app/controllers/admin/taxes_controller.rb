class Admin::TaxesController < Admin::ApplicationController
  def new
    @tax = Tax.new
  end

  def edit
    @tax = Tax.find(params[:id])
  end

  def index
    @taxes = Tax.all
  end

  def create
    @tax = Tax.new(tax_params)
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
      params.require(:tax).permit(:name, :percentage)
    end
end
