class AddSubtotalTaxAmountToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :subtotal, :decimal, precision: 10, scale: 2, null: false, default: 0.0, after: :outlet_id
    add_column :orders, :tax_amount, :decimal, precision: 10, scale: 2, null: false, default: 0.0, after: :subtotal
  end
end
