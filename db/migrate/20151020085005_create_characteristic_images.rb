class CreateCharacteristicImages < ActiveRecord::Migration[5.2]
  def change
    create_table :characteristic_images do |t|
      t.string :name
      t.references :characteristic, index: true

      t.timestamps null: false
    end
    add_foreign_key :characteristic_images, :characteristics
  end
end
