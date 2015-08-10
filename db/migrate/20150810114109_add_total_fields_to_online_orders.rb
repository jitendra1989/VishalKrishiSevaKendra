class AddTotalFieldsToOnlineOrders < ActiveRecord::Migration
  def change
  	add_column :online_orders, :subtotal, :decimal, precision: 10, scale: 2, null: false, default: 0.0, after: :customer_id
  	add_column :online_orders, :tax_amount, :decimal, precision: 10, scale: 2, null: false, default: 0.0, after: :subtotal
  end
end
