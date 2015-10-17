class AddFullyTaxableToTaxes < ActiveRecord::Migration
  def change
    add_column :taxes, :fully_taxable, :boolean, default: true, null: false
  end
end
