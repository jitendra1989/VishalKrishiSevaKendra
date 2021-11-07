class AddAncestryToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :ancestry, :string, after: :name
    add_index :categories, :ancestry
  end
end
