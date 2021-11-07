class AddBlockedAtToOnlineCarts < ActiveRecord::Migration[5.2]
  def change
    add_column :online_carts, :blocked_at, :datetime, after: :customer_id
  end
end
