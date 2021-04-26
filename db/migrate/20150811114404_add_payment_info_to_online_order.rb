class AddPaymentInfoToOnlineOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :online_orders, :payment_info, :text, after: :tax_amount
  end
end
