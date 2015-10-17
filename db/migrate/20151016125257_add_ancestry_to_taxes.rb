class AddAncestryToTaxes < ActiveRecord::Migration
  def change
    add_column :taxes, :ancestry, :string, after: :name
    add_index :taxes, :ancestry
  end
end
