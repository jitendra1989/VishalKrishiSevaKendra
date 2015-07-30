class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :code
      t.decimal :amount, precision: 10, scale: 2
      t.references :order, index: true
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :receipts, :orders
    add_foreign_key :receipts, :users
  end
end
