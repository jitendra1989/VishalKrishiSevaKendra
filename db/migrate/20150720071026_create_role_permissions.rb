class CreateRolePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :role_permissions do |t|
      t.references :role, index: true
      t.references :permission, index: true

      t.timestamps null: false
    end
    add_foreign_key :role_permissions, :roles
    add_foreign_key :role_permissions, :permissions
  end
end
