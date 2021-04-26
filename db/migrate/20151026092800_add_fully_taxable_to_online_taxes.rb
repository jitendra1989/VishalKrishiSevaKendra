class AddFullyTaxableToOnlineTaxes < ActiveRecord::Migration[5.2]
  def change
    add_column :online_taxes, :fully_taxable, :boolean, default: true, null: false
  end
end
