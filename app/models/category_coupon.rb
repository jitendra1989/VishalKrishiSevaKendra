class CategoryCoupon < ActiveRecord::Base
  belongs_to :category
  belongs_to :coupon_code
end
