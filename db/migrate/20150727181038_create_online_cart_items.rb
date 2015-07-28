class CreateOnlineCartItems < ActiveRecord::Migration
  def change
    create_table :online_cart_items do |t|
      t.references :product, index: true
      t.references :online_cart, index: true
      t.integer :quantity, :integer, null: false, default: 0

      t.timestamps null: false
    end
    add_foreign_key :online_cart_items, :products
    add_foreign_key :online_cart_items, :online_carts
  end
end
