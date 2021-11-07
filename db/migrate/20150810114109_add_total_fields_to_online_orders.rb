class AddTotalFieldsToOnlineOrders < ActiveRecord::Migration[5.2]
  def change
  	add_column :online_orders, :subtotal, :decimal, precision: 10, scale: 2, null: false, default: 0.0, after: :customer_id
  	add_column :online_orders, :tax_amount, :decimal, precision: 10, scale: 2, null: false, default: 0.0, after: :subtotal
  end
end
