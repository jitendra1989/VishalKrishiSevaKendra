class CreateCategoryCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :category_coupons do |t|
      t.references :category, index: true
      t.references :coupon_code, index: true

      t.timestamps null: false
    end
    add_foreign_key :category_coupons, :categories
    add_foreign_key :category_coupons, :coupon_codes
  end
end
