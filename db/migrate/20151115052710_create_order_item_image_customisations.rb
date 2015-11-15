class CreateOrderItemImageCustomisations < ActiveRecord::Migration
  def change
    create_table :order_item_image_customisations do |t|
      t.references :order_item, index: true
      t.references :characteristic, index: true
      t.references :characteristic_image, index: true

      t.timestamps null: false
    end
    add_foreign_key :order_item_image_customisations, :order_items
    add_foreign_key :order_item_image_customisations, :characteristics
    add_foreign_key :order_item_image_customisations, :characteristic_images
  end
end
