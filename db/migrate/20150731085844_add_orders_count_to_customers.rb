class AddOrdersCountToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :orders_count, :integer, default: 0, null: false, after: :country
  end
end
