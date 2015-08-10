class Admin::OnlineTaxesController < Admin::ApplicationController
  load_and_authorize_resource
  def new
  end

  def edit
  end

  def index
  end

  def create
    @online_tax = OnlineTax.new(online_tax_params)
    if @online_tax.save
      redirect_to admin_online_taxes_url, flash: { success: 'OnlineTax was successfully created.' }
    else
      render :new
    end
  end

  def update
    if @online_tax.update(online_tax_params)
      redirect_to admin_online_taxes_url, flash: { success: 'OnlineTax was successfully updated.' }
    else
      render :edit
    end
  end

  def destroy
    @online_tax.destroy
    redirect_to admin_online_taxes_url, flash: { info: 'OnlineTax was successfully deleted.' }
  end

  private
    def online_tax_params
      params.require(:online_tax).permit(:name, :percentage)
    end
end
