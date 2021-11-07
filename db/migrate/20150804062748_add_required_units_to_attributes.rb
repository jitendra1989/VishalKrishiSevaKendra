class AddRequiredUnitsToAttributes < ActiveRecord::Migration[5.2]
  def up
    remove_column :attributes, :outlet_only
    add_column :attributes, :required, :boolean, default: false, null: false, after: :name
    add_column :attributes, :units, :string, after: :required
  end
  def down
    remove_column :attributes, :required
    remove_column :attributes, :units
    add_column :attributes, :outlet_only, :boolean, default: false, null: false, after: :name
  end
end
