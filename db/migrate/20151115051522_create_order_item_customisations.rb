class CreateOrderItemCustomisations < ActiveRecord::Migration[5.2]
  def change
    create_table :order_item_customisations do |t|
      t.references :order_item, index: true
      t.references :specification, index: true
      t.string :value

      t.timestamps null: false
    end
    add_foreign_key :order_item_customisations, :order_items
    add_foreign_key :order_item_customisations, :specifications
  end
end
