class AddRequireWorkshopToProductTypes < ActiveRecord::Migration
  def change
    add_column :product_types, :require_workshop, :boolean, default: false, null: false, after: :name
  end
end
