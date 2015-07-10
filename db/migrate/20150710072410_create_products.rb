class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :code
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.boolean :active, null: false, default: false

      t.timestamps null: false
    end
  end
end
