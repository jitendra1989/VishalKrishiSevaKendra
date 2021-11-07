class AddCouponCodeToOnlineCart < ActiveRecord::Migration[5.2]
  def change
    add_reference :online_carts, :coupon_code, index: true, after: :customer_id
    add_foreign_key :online_carts, :coupon_codes
  end
end
