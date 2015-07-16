class AddProductTypeToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :product_type, index: true, after: :price
    add_foreign_key :products, :product_types
  end
end
