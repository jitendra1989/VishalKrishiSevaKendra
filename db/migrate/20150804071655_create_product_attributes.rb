class CreateProductAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :product_attributes do |t|
      t.references :product, index: true
      t.references :attribute, index: true
      t.string :value

      t.timestamps null: false
    end
    add_foreign_key :product_attributes, :products
    add_foreign_key :product_attributes, :attributes
  end
end
