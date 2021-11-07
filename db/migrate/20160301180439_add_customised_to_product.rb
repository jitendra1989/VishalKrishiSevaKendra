class AddCustomisedToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :customised, :boolean, default: false, null: false, after: :active
  end
end
