class AddDiscountToRole < ActiveRecord::Migration
  def change
		add_column :roles, :discount_percent, :decimal, precision: 10, scale: 2, null: false, default: 0.0, after: :name
  end
end
