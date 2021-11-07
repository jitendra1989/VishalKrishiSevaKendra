class AddDeletedAtToOutlets < ActiveRecord::Migration[5.2]
  def change
    add_column :outlets, :deleted_at, :datetime
    add_index :outlets, :deleted_at
  end
end
