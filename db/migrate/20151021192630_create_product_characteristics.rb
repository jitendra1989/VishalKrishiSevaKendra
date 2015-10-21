class CreateProductCharacteristics < ActiveRecord::Migration
  def change
    create_table :product_characteristics do |t|
      t.references :product, index: true
      t.references :characteristic, index: true
      t.references :characteristic_image, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_characteristics, :products
    add_foreign_key :product_characteristics, :characteristics
    add_foreign_key :product_characteristics, :characteristic_images
    add_index :product_characteristics, [:product_id, :characteristic_id], name: 'product_characteristic', unique: true
  end
end
