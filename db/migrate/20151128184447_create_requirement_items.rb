class CreateRequirementItems < ActiveRecord::Migration
  def change
    create_table :requirement_items do |t|
      t.references :requirement, index: true
      t.references :product, index: true
      t.string :name
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2
      t.text :description

      t.timestamps null: false
    end
    add_foreign_key :requirement_items, :requirements
    add_foreign_key :requirement_items, :products
  end
end
