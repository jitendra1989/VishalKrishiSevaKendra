class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :customer, index: true
      t.references :user, index: true
      t.references :outlet, index: true
      t.decimal :discount_amount, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :orders, :customers
    add_foreign_key :orders, :users
    add_foreign_key :orders, :outlets
  end
end
