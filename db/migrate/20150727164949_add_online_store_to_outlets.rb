class AddOnlineStoreToOutlets < ActiveRecord::Migration
  def change
    add_column :outlets, :online_store, :boolean, default: false, null: false, after: :city
  end
end
