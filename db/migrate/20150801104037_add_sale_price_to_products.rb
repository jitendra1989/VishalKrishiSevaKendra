class AddSalePriceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sale_price, :decimal, default: 0.0, null: false, precision: 10, scale: 2, after: :price
  end
end
