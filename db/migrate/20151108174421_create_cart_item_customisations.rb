class CreateCartItemCustomisations < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_item_customisations do |t|
      t.references :cart_item, index: true
      t.references :specification, index: true
      t.string :value

      t.timestamps null: false
    end
    add_foreign_key :cart_item_customisations, :cart_items
    add_foreign_key :cart_item_customisations, :specifications
  end
end
