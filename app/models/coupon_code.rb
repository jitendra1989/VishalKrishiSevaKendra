class CouponCode < ActiveRecord::Base
	[:code, :active_from, :active_to].each { |n| validates n, presence: true }
	validates :percent, numericality: true

	validate :active_date_range, if: lambda { |c| c.active_to && c.active_from  }

	private
		def active_date_range
			errors[:active_to] << 'should be after Active from' if self.active_to < self.active_from
		end

end
