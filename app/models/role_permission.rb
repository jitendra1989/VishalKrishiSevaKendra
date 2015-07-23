class RolePermission < ActiveRecord::Base
  belongs_to :role
  belongs_to :permission
  after_save :set_user_permissions

  private
    def set_user_permissions
      self.role.users.each do |user|
        user.permissions << self.permission
      end
    end
end
