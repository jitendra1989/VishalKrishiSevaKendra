class CreateProductCoupons < ActiveRecord::Migration
  def change
    create_table :product_coupons do |t|
      t.references :product, index: true
      t.references :coupon_code, index: true

      t.timestamps null: false
    end
    add_foreign_key :product_coupons, :products
    add_foreign_key :product_coupons, :coupon_codes
  end
end
