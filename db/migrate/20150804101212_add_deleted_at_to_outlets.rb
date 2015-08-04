class AddDeletedAtToOutlets < ActiveRecord::Migration
  def change
    add_column :outlets, :deleted_at, :datetime
    add_index :outlets, :deleted_at
  end
end
