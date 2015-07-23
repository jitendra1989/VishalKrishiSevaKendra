class AddDefaultQuantityToCartItem < ActiveRecord::Migration
  def up
    change_column :cart_items, :quantity, :integer, null: false, default: 0
  end

  def down
    change_column :cart_items, :quantity, :integer
  end
end
