class CreateUserRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_roles do |t|
      t.references :user, index: true
      t.references :role, index: true

      t.timestamps null: false
    end
    add_foreign_key :user_roles, :users
    add_foreign_key :user_roles, :roles
  end
end
