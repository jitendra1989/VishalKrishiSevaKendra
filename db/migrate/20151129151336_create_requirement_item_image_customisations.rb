class CreateRequirementItemImageCustomisations < ActiveRecord::Migration
  def change
    create_table :requirement_item_image_customisations do |t|
      t.references :requirement_item, index: { name: 'index_req_item_riic' }
      t.references :characteristic, index: { name: 'index_characterisic_riic' }
      t.references :characteristic_image, index: { name: 'index_char_img_riic' }

      t.timestamps null: false
    end
    add_foreign_key :requirement_item_image_customisations, :requirement_items
    add_foreign_key :requirement_item_image_customisations, :characteristics
    add_foreign_key :requirement_item_image_customisations, :characteristic_images
  end
end
