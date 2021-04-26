class ProductCoupon < ApplicationRecord
  belongs_to :product
  belongs_to :coupon_code
end
