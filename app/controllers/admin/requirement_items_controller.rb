class Admin::RequirementItemsController < Admin::ApplicationController
  before_action :set_requirement_item, only: [:show, :edit, :update, :destroy]
  authorize_resource :requirement
  authorize_resource :requirement_item, through: :requirement, shallow: true

  def edit
  end

  def update
    if @requirement_item.update(requirement_item_params)
      redirect_to edit_admin_requirement_item_url(@requirement_item), flash: { success: 'Requirement form was successfully updated.' }
    else
      render :edit
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement_item
      @requirement_item = RequirementItem.includes(image_customisations: [:characteristic, :characteristic_image]).find(params[:id])
      @requirement = @requirement_item.requirement
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requirement_item_params
      params.require(:requirement_item).permit(customisations_attributes: [:id, :specification_id, :value, :_destroy], image_customisations_attributes: [:id, :characteristic_id, :characteristic_image_id, :_destroy])
    end
end
