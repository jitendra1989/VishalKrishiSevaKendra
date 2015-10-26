class AddFullyTaxableToOnlineTaxes < ActiveRecord::Migration
  def change
    add_column :online_taxes, :fully_taxable, :boolean, default: true, null: false
  end
end
