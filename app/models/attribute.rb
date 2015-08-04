class Attribute < ActiveRecord::Base
	UNITS = %w(meter gram)
	has_many :product_attributes


	validates :name, presence: true
	validates :units, inclusion: { in: UNITS }
end
