class AddPercentageToOrderTax < ActiveRecord::Migration[5.2]
  def change
    add_column :order_taxes, :percentage, :float, default: 0.0, null: false, after: :name
  end
end
