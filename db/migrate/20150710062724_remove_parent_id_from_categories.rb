class RemoveParentIdFromCategories < ActiveRecord::Migration[5.2]
  def change
  	remove_foreign_key :categories, column: :parent_id
    remove_column :categories, :parent_id
  end
end
