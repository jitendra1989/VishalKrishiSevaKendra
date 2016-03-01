class AddCustomisedToProduct < ActiveRecord::Migration
  def change
    add_column :products, :customised, :boolean, default: false, null: false, after: :active
  end
end
