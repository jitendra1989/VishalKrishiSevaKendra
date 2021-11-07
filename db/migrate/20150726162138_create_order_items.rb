class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.references :order, index: true
      t.references :product, index: true
      t.string :name
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :products
  end
end
