class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.string :name
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_images, :products
  end
end
