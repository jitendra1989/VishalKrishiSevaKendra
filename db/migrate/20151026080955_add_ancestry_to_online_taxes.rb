class AddAncestryToOnlineTaxes < ActiveRecord::Migration
  def change
    add_column :online_taxes, :ancestry, :string, after: :percentage
    add_index :online_taxes, :ancestry
  end
end
