class RemoveRoleFromUsers < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :role, :string, after: :outlet_id
  end
end
