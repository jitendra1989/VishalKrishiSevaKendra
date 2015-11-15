class CreateCartItemImageCustomisations < ActiveRecord::Migration
  def change
    create_table :cart_item_image_customisations do |t|
      t.references :cart_item, index: true
      t.references :characteristic, index: true
      t.references :characteristic_image, index: true

      t.timestamps null: false
    end
    add_foreign_key :cart_item_image_customisations, :cart_items
    add_foreign_key :cart_item_image_customisations, :characteristics
    add_foreign_key :cart_item_image_customisations, :characteristic_images
  end
end
