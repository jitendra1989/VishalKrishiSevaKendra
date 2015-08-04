class RenameAttributesToSpecifications < ActiveRecord::Migration
  def up
    remove_foreign_key :product_attributes, :attributes
    rename_table :attributes, :specifications
    rename_table :product_attributes, :product_specifications
    rename_column :product_specifications, :attribute_id, :specification_id
    add_foreign_key :product_specifications, :specifications
  end
  def down
    remove_foreign_key :product_specifications, :specifications
    rename_table :specifications, :attributes
    rename_table :product_specifications, :product_attributes
    rename_column :product_attributes, :specification_id, :attribute_id
    add_foreign_key :product_attributes, :attributes
  end
end
