class CreateCouponCodes < ActiveRecord::Migration
  def change
    create_table :coupon_codes do |t|
      t.string :code
      t.decimal :percent, precision: 10, scale: 2
      t.boolean :active, null: false, default: false
      t.datetime :active_from
      t.datetime :active_to

      t.timestamps null: false
    end
  end
end
