class AddAncestryToProductTypeTax < ActiveRecord::Migration
  def change
    add_column :product_type_taxes, :ancestry, :string, after: :tax_id
  end
end
