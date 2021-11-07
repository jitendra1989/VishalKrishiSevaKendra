class AddColumnParentIdToVillage < ActiveRecord::Migration[6.0]
  def change
    add_column :villages, :parent_id, :integer, after: :name
  end
end
