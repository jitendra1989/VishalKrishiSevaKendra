class CreateStockNotifications < ActiveRecord::Migration
  def change
    create_table :stock_notifications do |t|
      t.references :customer, index: true, null: false
      t.references :product, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :stock_notifications, :customers
    add_foreign_key :stock_notifications, :products
    add_index :stock_notifications, [:customer_id, :product_id], unique: true
  end
end
