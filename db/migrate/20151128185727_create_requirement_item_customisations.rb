class CreateRequirementItemCustomisations < ActiveRecord::Migration[5.2]
  def change
    create_table :requirement_item_customisations do |t|
      t.references :requirement_item, index: true
      t.references :specification, index: true
      t.string :value

      t.timestamps null: false
    end
    add_foreign_key :requirement_item_customisations, :requirement_items
    add_foreign_key :requirement_item_customisations, :specifications
  end
end
