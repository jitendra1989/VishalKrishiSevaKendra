class AddFlagsToUser < ActiveRecord::Migration
  def change
    add_column :users, :flags, :integer, null: false, default: 0, after: :active
  end
end
