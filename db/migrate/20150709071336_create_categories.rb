class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :parent, index: true

      t.timestamps null: false
    end
    add_foreign_key :categories, :categories, column: :parent_id
  end
end
