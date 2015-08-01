class AddInvoiceToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :invoice, index: true
    add_foreign_key :orders, :invoices
  end
end
