class AddUserToOrderItemCustomisations < ActiveRecord::Migration
  def change
    add_reference :order_item_customisations, :user, index: true, after: :value
    add_foreign_key :order_item_customisations, :users
    add_reference :order_item_image_customisations, :user, index: true, after: :characteristic_image_id
    add_foreign_key :order_item_image_customisations, :users
  end
end
