class Attribute < ActiveRecord::Base
	UNITS = %w(meter gram)
	validates :name, presence: true
	validates :units, inclusion: { in: UNITS }
end
