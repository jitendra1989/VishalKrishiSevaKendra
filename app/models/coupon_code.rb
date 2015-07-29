class CouponCode < ActiveRecord::Base
	[:code, :percent, :active_from, :active_to].each { |n| validates n, presence: true }
end
