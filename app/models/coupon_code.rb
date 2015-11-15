class CouponCode < ActiveRecord::Base
	has_many :product_coupons, dependent: :destroy
	has_many :products, through: :product_coupons
	has_many :category_coupons, dependent: :destroy
	has_many :categories, through: :category_coupons

	[:code, :active_from, :active_to].each { |n| validates n, presence: true }
	validates :percent, numericality: true
	validate :active_date_range, if: lambda { |c| c.active_to && c.active_from  }

	attr_writer :current_step

	def current_step
		@current_step || steps.first
	end

	def next_step
		self.current_step = steps[steps.index(current_step)+1]
	end

	def previous_step
		self.current_step = steps[steps.index(current_step)-1]
	end

	def first_step?
		current_step == steps.first
	end

	def last_step?
		current_step == steps.last
	end

	def steps
		%w[info products]
	end

	private
		def active_date_range
			errors[:active_to] << 'should be after Active from' if self.active_to < self.active_from
		end

end
