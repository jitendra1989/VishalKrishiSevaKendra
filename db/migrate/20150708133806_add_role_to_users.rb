class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, after: :outlet_id
  end
end
