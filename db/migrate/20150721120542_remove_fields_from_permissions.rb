class RemoveFieldsFromPermissions < ActiveRecord::Migration
  def change
  	remove_column :permissions, :subject_id, :integer, after: :subject_class
  	remove_column :permissions, :subject_class, :string, after: :name
  end
end
