class AddBlockedAtToOnlineCarts < ActiveRecord::Migration
  def change
    add_column :online_carts, :blocked_at, :datetime, after: :customer_id
  end
end
