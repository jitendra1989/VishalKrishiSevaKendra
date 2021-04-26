class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :quantity
      t.references :product, index: true
      t.references :outlet, index: true
      t.text :details

      t.timestamps null: false
    end
    add_foreign_key :stocks, :products
    add_foreign_key :stocks, :outlets
  end
end
