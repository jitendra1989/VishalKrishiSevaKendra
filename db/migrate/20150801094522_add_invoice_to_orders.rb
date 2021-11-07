class AddInvoiceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :invoice, index: true
    add_foreign_key :orders, :invoices
  end
end
