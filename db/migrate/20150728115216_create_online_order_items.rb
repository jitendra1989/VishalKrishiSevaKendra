class CreateOnlineOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :online_order_items do |t|
      t.references :online_order, index: true
      t.references :product, index: true
      t.string :name
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :online_order_items, :online_orders
    add_foreign_key :online_order_items, :products
  end
end
