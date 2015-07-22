class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :product, index: true
      t.references :cart, index: true
      t.integer :quantity

      t.timestamps null: false
    end
    add_foreign_key :cart_items, :products
    add_foreign_key :cart_items, :carts
  end
end
