class AddSaleableOnlineToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :saleable_online, :boolean, default: false, null: false, after: :product_type_id
  end
end
