class CreateOnlineOrders < ActiveRecord::Migration
  def change
    create_table :online_orders do |t|
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :online_orders, :customers
  end
end
