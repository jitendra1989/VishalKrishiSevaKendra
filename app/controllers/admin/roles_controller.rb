class Admin::RolesController < Admin::ApplicationController
  def index
    @roles = Role.all
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def edit
    @role = Role.find(params[:id])
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to admin_roles_url, flash: { success: 'Role was successfully created.' }
    else
      render :new
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update(role_params)
      redirect_to admin_roles_url, flash: { success: 'Role was successfully updated.' }
    else
      render :edit
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to admin_roles_url, flash: { info: 'Role was successfully deleted.' }
  end

  private
    def role_params
      params.require(:role).permit(:name, permission_ids: [])
    end
end
