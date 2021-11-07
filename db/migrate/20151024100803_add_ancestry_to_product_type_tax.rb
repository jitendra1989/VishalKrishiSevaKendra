class AddAncestryToProductTypeTax < ActiveRecord::Migration[5.2]
  def change
    add_column :product_type_taxes, :ancestry, :string, after: :tax_id
  end
end
