class CouponCode < ActiveRecord::Base
	[:code, :active_from, :active_to].each { |n| validates n, presence: true }
	validates :percent, numericality: true
end
