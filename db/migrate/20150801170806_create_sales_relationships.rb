class CreateSalesRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :sales_relationships do |t|
      t.references :product, index: true
      t.references :related_product, index: true
      t.string :type

      t.timestamps null: false
    end
    add_foreign_key :sales_relationships, :products
    add_foreign_key :sales_relationships, :products, column: :related_product_id
  end
end
