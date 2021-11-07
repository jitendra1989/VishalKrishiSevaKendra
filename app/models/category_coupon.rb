class CategoryCoupon < ApplicationRecord
  belongs_to :category
  belongs_to :coupon_code
end
