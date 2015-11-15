class AddStatusToOrderItemCustomisation < ActiveRecord::Migration
  def change
    add_column :order_item_customisations, :status, :integer, default: 0, null: false, after: :value
    add_column :order_item_image_customisations, :status, :integer, default: 0, null: false, after: :characteristic_image_id
  end
end
