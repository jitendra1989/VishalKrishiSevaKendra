class Admin::PermissionsController < Admin::ApplicationController
  def index
  	@permissions = Permission.all
  end
end
