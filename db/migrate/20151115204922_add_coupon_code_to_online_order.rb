class AddCouponCodeToOnlineOrder < ActiveRecord::Migration
  def change
    add_reference :online_orders, :coupon_code, index: true, after: :tax_amount
    add_foreign_key :online_orders, :coupon_codes
  end
end
