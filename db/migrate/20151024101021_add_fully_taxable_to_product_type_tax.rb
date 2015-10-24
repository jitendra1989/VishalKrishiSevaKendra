class AddFullyTaxableToProductTypeTax < ActiveRecord::Migration
  def change
    add_column :product_type_taxes, :fully_taxable, :boolean, default: true, null: false, after: :ancestry
  end
end
