class AddOrderCustomisationsCountToOrderItem < ActiveRecord::Migration
  def change
    add_column :order_items, :customisations_count, :integer, default: 0, null: false, after: :price
    add_column :order_items, :image_customisations_count, :integer, default: 0, null: false, after: :customisations_count
  end
end
