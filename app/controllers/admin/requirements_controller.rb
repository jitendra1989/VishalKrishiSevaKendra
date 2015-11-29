class Admin::RequirementsController < Admin::ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]

  def index
    @requirements = Requirement.all
  end

  def show
  end

  def new
    @requirement = Requirement.new
  end

  def edit
  end

  def create
    @requirement = Requirement.new(requirement_params.merge(user: current_user))
    if @requirement.save
      redirect_to edit_admin_requirement_url(@requirement), flash: { success: 'Requirement was successfully created.' }
    else
      render :new
    end
  end

  def update
    if @requirement.update(requirement_params)
      redirect_to edit_admin_requirement_url(@requirement), flash: { success: 'Requirement was successfully updated.' }
      else
        render :edit
    end
  end

  def destroy
    @requirement.destroy
    redirect_to admin_requirements_url, notice: 'Requirement was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requirement_params
      params.require(:requirement).permit(products_attributes: [:id, :product_id, :quantity, :_destroy])
    end
end
