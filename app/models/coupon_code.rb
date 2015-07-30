class CouponCode < ActiveRecord::Base
	[:code, :active_from, :active_to].each { |n| validates n, presence: true }
	validates :percent, numericality: true

	validates :active_to, numericality: { greater_than: lambda { |c| c.active_from.to_i }, message: 'Must be greater than Active From' }

end
