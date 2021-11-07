class AddReceiptsCountToOrders < ActiveRecord::Migration[5.2]
  def change
  	add_column :orders, :receipts_count, :integer, default: 0, null: false, after: :discount_amount
  end
end
