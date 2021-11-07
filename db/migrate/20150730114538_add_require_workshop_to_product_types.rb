class AddRequireWorkshopToProductTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :product_types, :require_workshop, :boolean, default: false, null: false, after: :name
  end
end
