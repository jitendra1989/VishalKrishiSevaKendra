class CreateQuotationProducts < ActiveRecord::Migration
  def change
    create_table :quotation_products do |t|
      t.references :quotation, index: true
      t.references :product, index: true
      t.string :name
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :quotation_products, :quotations
    add_foreign_key :quotation_products, :products
  end
end
