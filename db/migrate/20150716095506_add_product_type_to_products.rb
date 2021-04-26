class AddProductTypeToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :product_type, index: true, after: :price
    add_foreign_key :products, :product_types
  end
end
