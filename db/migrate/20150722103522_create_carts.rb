class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :customer, index: true
      t.references :user, index: true
      t.references :outlet, index: true

      t.timestamps null: false
    end
    add_foreign_key :carts, :customers
    add_foreign_key :carts, :users
    add_foreign_key :carts, :outlets
    add_index :carts, [:outlet_id, :customer_id], unique: true
  end
end
