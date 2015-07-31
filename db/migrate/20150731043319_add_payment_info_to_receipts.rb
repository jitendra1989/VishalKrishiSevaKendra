class AddPaymentInfoToReceipts < ActiveRecord::Migration
  def change
    add_column :receipts, :payment_method, :integer, default: 1, null: false, after: :amount
    add_column :receipts, :payment_info, :text, after: :payment_method
  end
end
