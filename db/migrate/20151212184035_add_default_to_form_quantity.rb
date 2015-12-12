class AddDefaultToFormQuantity < ActiveRecord::Migration
  def up
    change_column :requirement_items, :quantity, :integer, null: false, default: 1
    change_column :requirement_items, :price, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    change_column :quotation_products, :quantity, :integer, null: false, default: 1
    change_column :quotation_products, :price, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end

  def down
    change_column :quotation_products, :quantity, :integer
    change_column :quotation_products, :price, :decimal, precision: 10, scale: 2
    change_column :requirement_items, :quantity, :integer
    change_column :requirement_items, :price, :decimal, precision: 10, scale: 2
  end
end
