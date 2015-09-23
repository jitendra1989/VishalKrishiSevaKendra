class AddDefaultDiscountAmountToOrders < ActiveRecord::Migration
	def up
		change_column :orders, :discount_amount, :decimal, precision: 10, scale: 2, null: false, default: 0.0
	end

	def down
		change_column :orders, :discount_amount, :decimal, precision: 10, scale: 2
	end

end
