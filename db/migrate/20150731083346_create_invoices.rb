class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.references :customer, index: true

      t.timestamps null: false
    end
    add_foreign_key :invoices, :customers
  end
end
