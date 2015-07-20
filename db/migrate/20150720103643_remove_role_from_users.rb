class RemoveRoleFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :role, :string, after: :outlet_id
  end
end
