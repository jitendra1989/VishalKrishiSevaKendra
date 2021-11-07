class CreateProductTypeTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_type_taxes do |t|
      t.references :product_type, index: true
      t.references :tax, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_type_taxes, :product_types
    add_foreign_key :product_type_taxes, :taxes
  end
end
