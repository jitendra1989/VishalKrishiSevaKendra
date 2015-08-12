class CreateGroupItems < ActiveRecord::Migration
  def change
    create_table :group_items do |t|
      t.references :product, index: true
      t.references :related_product, index: true
      t.integer :quantity

      t.timestamps null: false
    end
    add_foreign_key :group_items, :products
    add_foreign_key :group_items, :products, column: :related_product_id
  end
end
