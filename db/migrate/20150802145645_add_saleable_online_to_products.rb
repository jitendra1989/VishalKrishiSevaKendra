class AddSaleableOnlineToProducts < ActiveRecord::Migration
  def change
    add_column :products, :saleable_online, :boolean, default: false, null: false, after: :product_type_id
  end
end
