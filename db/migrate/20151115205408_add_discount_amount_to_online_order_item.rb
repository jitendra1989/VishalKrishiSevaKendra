class AddDiscountAmountToOnlineOrderItem < ActiveRecord::Migration
  def change
    add_column :online_order_items, :discount_amount, :decimal, precision: 10, scale: 2, null: false, default: 0.0, after: :price
  end
end
