class AddOverridenToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :overridden, :boolean, default: false, null: false, after: :receipts_count
  end
end
