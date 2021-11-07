class RemoveFieldsFromPermissions < ActiveRecord::Migration[5.2]
  def change
  	remove_column :permissions, :subject_id, :integer, after: :subject_class
  	remove_column :permissions, :subject_class, :string, after: :name
  end
end
