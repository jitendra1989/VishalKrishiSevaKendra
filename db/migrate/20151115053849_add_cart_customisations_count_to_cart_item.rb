class AddCartCustomisationsCountToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_column :cart_items, :customisations_count, :integer, default: 0, null: false, after: :quantity
    add_column :cart_items, :image_customisations_count, :integer, default: 0, null: false, after: :customisations_count
  end
end
