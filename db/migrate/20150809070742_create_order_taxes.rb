class CreateOrderTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :order_taxes do |t|
      t.references :order, index: true
      t.string :name
      t.decimal :amount, default: 0.0, null: false, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :order_taxes, :orders
  end
end
