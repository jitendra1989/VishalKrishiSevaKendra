class AddReceiptsCountToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :receipts_count, :integer, default: 0, null: false, after: :discount_amount
  end
end
