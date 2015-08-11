class AddPaymentInfoToOnlineOrder < ActiveRecord::Migration
  def change
    add_column :online_orders, :payment_info, :text, after: :tax_amount
  end
end
