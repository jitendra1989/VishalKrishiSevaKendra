class CreateOnlineOrderTaxes < ActiveRecord::Migration
  def change
    create_table :online_order_taxes do |t|
      t.references :online_order, index: true
      t.string :name
      t.decimal :amount, default: 0.0, null: false, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :online_order_taxes, :online_orders
  end
end
